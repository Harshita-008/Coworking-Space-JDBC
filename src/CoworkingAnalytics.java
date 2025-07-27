import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class CoworkingAnalytics {

    static String url;
    static String username;
    static String password;

    public static void main(String[] args){
        // Loading DB config
        loadDBConfig();

        // Loading the driver, forming connection and getting the result
        try {
            // Loading the driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver Loaded.");

            // Checking if database exists
            if (!databaseExists("coworking_space_management")) {
                System.out.println("Database not found. Creating and initializing it now...");
                runSQLScript("resources/coworking_schema.sql");
                runSQLScript("resources/sample_data.sql");
                System.out.println("Schema executed successfully.");
            }

            // Forming connection and getting the result
            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                spaceUtilizationRates(conn);
                popularServicesAndAmenities(conn);
                eventParticipationStats(conn);
                meetingRoomBookingPatterns(conn);
                revenuePerSqft(conn);
                memberRetentionMetrics(conn);
                peakUsageHours(conn);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Loading database config from config.properties
    public static void loadDBConfig() {
        try {
            Properties props = new Properties();
            props.load(new FileInputStream("resources/config.properties"));
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
        } catch (IOException e) {
            System.err.println("Failed to load config.properties");
            e.printStackTrace();
        }
    }

    // Checking if database exists
    public static boolean databaseExists(String dbName) {
        String tempUrl = "jdbc:mysql://localhost:3306/?useSSL=false";
        try (Connection conn = DriverManager.getConnection(tempUrl, username, password);
             ResultSet rs = conn.getMetaData().getCatalogs()) {
            while (rs.next()) {
                if (rs.getString(1).equalsIgnoreCase(dbName)) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking database existence.");
            e.printStackTrace();
        }
        return false;
    }

    // Running the SQL script (schema)
    public static void runSQLScript(String filePath) {
        try {
            // Creating database first
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/?allowMultiQueries=true", username, password)) {
                conn.createStatement().execute("CREATE DATABASE IF NOT EXISTS coworking_space_management");
            }
            // Running script 
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coworking_space_management?allowMultiQueries=true", username, password)) {
                String sql = new String(java.nio.file.Files.readAllBytes(java.nio.file.Paths.get(filePath)));
                conn.createStatement().execute(sql);
            }
        } catch (Exception e) {
            System.err.println("Error running SQL script.");
            e.printStackTrace();
        }
    }

    // QUERIES:
    // 1. Space utilization by location and membership type
    public static void spaceUtilizationRates(Connection conn) throws SQLException {
        String query = """
            SELECT l.city, m.access_level, COUNT(uh.membership_id) AS member_count
            FROM Location l
            JOIN Desk_Office d ON l.location_id = d.location_id
            JOIN Unpaid_Booking ub ON ub.resource_id = d.item_id
            JOIN Member_History uh ON uh.member_id = ub.member_id
            JOIN Membership m ON uh.membership_id = m.membership_id
            GROUP BY l.city, m.access_level
            ORDER BY l.city, m.access_level;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("=== Space Utilization by Location and Membership Type ===");
            while (rs.next()) {
                System.out.printf("City: %s | Type: %s | Members: %d%n", rs.getString("city"), rs.getString("access_level"), rs.getInt("member_count"));
            }
        }
    }

    // 2. Most popular services and amenities
    public static void popularServicesAndAmenities(Connection conn) throws SQLException {
        String query = """
            SELECT s.service_type, SUM(su.quantity) AS total_usage
            FROM Service_Usage su
            JOIN Service s ON su.service_id = s.service_id
            GROUP BY s.service_type
            ORDER BY total_usage DESC;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Popular Services and Amenities ===");
            while (rs.next()) {
                System.out.printf("Service: %s | Usage: %d%n", rs.getString("service_type"), rs.getInt("total_usage"));
            }
        }
    }

    // 3. Event participation / Networking activity
    public static void eventParticipationStats(Connection conn) throws SQLException {
        String query = """
            SELECT e.event_name, COUNT(ep.attendee_id) AS attendees
            FROM Events e
            JOIN Event_Participation ep ON e.event_id = ep.event_id
            GROUP BY e.event_name
            ORDER BY attendees DESC;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Event Participation ===");
            while (rs.next()) {
                System.out.printf("Event: %s | Attendees: %d%n", rs.getString("event_name"), rs.getInt("attendees"));
            }
        }
    }

    // 4. Meeting room booking patterns
    public static void meetingRoomBookingPatterns(Connection conn) throws SQLException {
        String query = """
            SELECT date, COUNT(*) AS total_bookings
            FROM Paid_Booking
            WHERE resource_type = 'Meeting Room'
            GROUP BY date
            ORDER BY date;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Meeting Room Booking Trends ===");
            while (rs.next()) {
                System.out.printf("Date: %s | Bookings: %d%n", rs.getDate("date"), rs.getInt("total_bookings"));
            }
        }
    }

    // 5. Revenue per square foot
    public static void revenuePerSqft(Connection conn) throws SQLException {
        String query = """
            SELECT l.city, ROUND(SUM(mb.amount)/SUM(l.sqft), 2) AS revenue_per_sqft
            FROM Member_Bill mb
            JOIN Location l ON mb.location_id = l.location_id
            GROUP BY l.city
            ORDER BY l.city;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Revenue per Square Foot ===");
            while (rs.next()) {
                System.out.printf("City: %s | Revenue/Sqft: Rs. %.2f%n", rs.getString("city"), rs.getDouble("revenue_per_sqft"));
            }
        }
    }

    // 6. Member retention metrics
    public static void memberRetentionMetrics(Connection conn) throws SQLException {
        String query = """
            SELECT status, COUNT(*) AS count
            FROM Member_History
            GROUP BY status
            ORDER BY status;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Member Retention ===");
            while (rs.next()) {
                System.out.printf("Status: %s | Members: %d%n", rs.getString("status"), rs.getInt("count"));
            }
        }
    }

    // 7. Peak usage hours for capacity planning
    public static void peakUsageHours(Connection conn) throws SQLException {
        String query = """
            SELECT HOUR(entry_time) AS hour, COUNT(*) AS total_entries
            FROM Access_Log
            GROUP BY hour
            ORDER BY total_entries DESC
            LIMIT 5;
        """;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n=== Peak Usage Hours ===");
            while (rs.next()) {
                System.out.printf("Hour: %02d:00 | Entries: %d%n", rs.getInt("hour"), rs.getInt("total_entries"));
            }
        }
    }
}
