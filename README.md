# Coworking Space Analytics (JDBC)

This project provides analytics for a coworking space management system using Java and JDBC. It connects to a MySQL database, initializes the schema and sample data if needed, and runs a series of analytics queries to provide insights such as space utilization, popular services, event participation, revenue, and more.

## Prerequisites

1. **Java Development Kit (JDK) 8 or higher**
   - Download and install from [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://adoptopenjdk.net/).

2. **MySQL Server**
   - Download and install from [MySQL Downloads](https://dev.mysql.com/downloads/installer/).
   - Make sure the MySQL server is running on `localhost:3306` (default).

3. **MySQL JDBC Driver**
   - Download the MySQL Connector/J from [MySQL Connector/J Downloads](https://dev.mysql.com/downloads/connector/j/).
   - Add the JAR to your project's classpath when compiling and running.

## Project Structure

```
Coworking-Space-JDBC/
├── resources/
│   ├── config.properties
│   ├── coworking_schema.sql
│   └── sample_data.sql
├── src/
│   └── CoworkingAnalytics.java
├── CoworkingAnalytics.jar (optional, if built)
└── manifest.txt (optional)
```

## Configuration

1. **Edit Database Credentials**

   - Open `resources/config.properties` in a text editor.
   - Update the following properties with your MySQL credentials:

     ```properties
     db.url=jdbc:mysql://localhost:3306/coworking_space_management?useSSL=false
     db.username=YOUR_MYSQL_USERNAME
     db.password=YOUR_NEW_PASSWORD
     ```
   - **Important:** Change `YOUR_NEW_PASSWORD` to your actual MySQL password.

2. **(Optional) Adjust Database URL**
   - If your MySQL server is running on a different host or port, update the `db.url` accordingly.

## Setup & Usage

### 1. Clone or Download the Project

```
git clone <repo-url>
cd Coworking-Space-JDBC
```

Or download and extract the ZIP, then navigate to the folder.

### 2. Ensure MySQL Server is Running

- Start your MySQL server if it is not already running.

### 3. Place the MySQL JDBC Driver in Classpath

- Download the MySQL Connector/J JAR file.
- Place it in your project directory or note its path for use in the next steps.

### 4. Build the Project (if needed)

If you want to compile the Java source manually:

```
javac -cp "path/to/mysql-connector-java-x.x.x.jar;resources" src/CoworkingAnalytics.java
```

Or use your IDE to build the project.

### 5. Run the Application

You can run the program using the compiled class or the provided JAR (if available):

#### a) Using the compiled class:

```
java -cp "src;resources;path/to/mysql-connector-java-x.x.x.jar" CoworkingAnalytics
```

#### b) Using the JAR file with classpath:

```
java -cp "CoworkingAnalytics.jar;resources;path/to/mysql-connector-java-x.x.x.jar" CoworkingAnalytics
```

#### c) Using the JAR file directly (recommended if the JAR is built with dependencies):

```
java -jar CoworkingAnalytics.jar
```

**Note:** If you use `java -jar`, make sure the JAR is built as an executable JAR with all dependencies included or available in the classpath. If the MySQL JDBC driver is not bundled, you may need to use the `-cp` approach above.

### 6. What Happens on First Run?

- The application will check if the `coworking_space_management` database exists.
- If not, it will automatically create the database and initialize the schema and sample data using the SQL scripts in `resources/`.
- Then, it will run a series of analytics queries and print the results to the console.

## Analytics Provided

1. **Space Utilization by Location and Membership Type**
2. **Most Popular Services and Amenities**
3. **Event Participation Statistics**
4. **Meeting Room Booking Patterns**
5. **Revenue per Square Foot**
6. **Member Retention Metrics**
7. **Peak Usage Hours for Capacity Planning**

## Troubleshooting

- **Driver Not Found:** Ensure the MySQL JDBC driver JAR is in your classpath.
- **Connection Issues:** Double-check your `config.properties` for correct username, password, and URL.
- **MySQL Not Running:** Start your MySQL server.
- **Permission Errors:** Ensure your MySQL user has privileges to create databases and tables.

## Customization

- To use your own data, modify or replace `resources/sample_data.sql`.
- To change the schema, edit `resources/coworking_schema.sql`.

## License

This project is for educational/demo purposes. Modify and use as needed. 