drop user 'dwh'@'%';
create user 'dwh'@'%' IDENTIFIED BY 'WZF25g77';
GRANT ALL PRIVILEGES ON *.* TO 'dwh'@'%' IDENTIFIED BY 'WZF25g77';
GRANT ALL PRIVILEGES ON *.* TO 'dwh'@'localhost' IDENTIFIED BY 'WZF25g77';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '556JNPVt';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '556JNPVt';

FLUSH PRIVILEGES;