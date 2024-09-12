<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="ABC Suppliers Management System">
    <title>ABC Suppliers Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        h1 {
            color: #007bff;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
        }

        .feature {
            background-color: #007bff;
            color: white;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin: 5px 0;
        }

        code {
            background-color: #f0f0f0;
            padding: 2px 4px;
            border-radius: 4px;
            color: #c7254e;
        }

        footer {
            text-align: center;
            margin-top: 50px;
            color: #555;
        }
    </style>
</head>

<body>

    <h1>ABC Suppliers Management System</h1>

    <div class="container">
        <h2>Project Overview</h2>
        <p>The <strong>ABC Suppliers Management System</strong> is a web-based application built using <code>Java JSP</code> for managing users, suppliers, products, orders, and audit logs. It also includes profile customization for users.</p>

        <h2>Features</h2>
        <ul>
            <li class="feature">Manage Users: Add, Edit, Delete, and View Users</li>
            <li class="feature">Suppliers Management: Add, Edit, Delete, and View Suppliers</li>
            <li class="feature">Products Management: Add, Edit, Delete, and View Products</li>
            <li class="feature">Order Management: Track and View Orders</li>
            <li class="feature">Audit Logs: Track changes and user actions (User Log, Suppliers Log, Products Log)</li>
            <li class="feature">Profile Customization: Users can update their profile information</li>
        </ul>

        <h2>Technologies Used</h2>
        <ul>
            <li>Java JSP (Java Server Pages)</li>
            <li>HTML/CSS for frontend</li>
            <li>JavaScript for UI interactions</li>
            <li>MySQL for database</li>
        </ul>

        <h2>Installation & Setup</h2>
        <p>To run this project locally:</p>
        <ol>
            <li>Clone the repository: <code>git clone https://github.com/username/supplier-management-system.git</code></li>
            <li>Navigate to the project directory: <code>cd supplier-management-system</code></li>
            <li>Import the MySQL database (SQL file included)</li>
            <li>Run the project on a Java web server (Tomcat, Jetty, etc.)</li>
            <li>Open the application in your browser: <code>http://localhost:8080/supplier-management</code></li>
        </ol>

        <h2>Screenshots</h2>
        <p>Here’s a look at the sidebar navigation:</p>
        <img src="screenshots/sidebar.png" alt="Sidebar Navigation" style="width:100%; max-width:400px;">

        <h2>Contributing</h2>
        <p>If you'd like to contribute to this project, feel free to fork the repository and submit a pull request.</p>

        <h2>License</h2>
        <p>This project is licensed under the MIT License.</p>
    </div>

    <footer>
        <p>Created with ❤️ by ABC Suppliers Development Team</p>
    </footer>

</body>

</html>
