CREATE USER 'replica_user'@'%' IDENTIFIED WITH caching_sha2_password BY 'rep_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
