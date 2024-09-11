SHOW MASTER STATUS;
STOP REPLICA;

CHANGE REPLICATION SOURCE TO
	SOURCE_HOST='mysql_master',
	SOURCE_USER='replica_user',
	SOURCE_PASSWORD='rep_password',
	SOURCE_LOG_FILE='master.000003',
	SOURCE_LOG_POS=158;
	-- SOURCE_DELAY=30;

START REPLICA;
SHOW REPLICA STATUS;

CREATE TABLE Person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
);
drop table Person;

INSERT INTO Person (first_name, last_name, age) VALUES
('John', 'Doe', 30),
('Jane', 'Smith', 25);

INSERT INTO Person (first_name, last_name, age) VALUES
('Leo', 'Doe', 10);


SELECT * FROM Person;

SELECT * FROM replication_connection_status

INSTALL PLUGIN rpl_semi_sync_source SONAME 'semisync_source.so';
INSTALL PLUGIN rpl_semi_sync_replica SONAME 'semisync_replica.so';

-- Can put this in mysqld.conf
SET GLOBAL rpl_semi_sync_source_enabled = 1;
SET GLOBAL rpl_semi_sync_replica_enabled = 1;

-- Run at slaves
STOP REPLICA IO_THREAD;
START REPLICA IO_THREAD;

