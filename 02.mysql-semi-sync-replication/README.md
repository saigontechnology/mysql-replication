# Semi-synchronous MySQL Replication

## How to set up

- Run `docker compose up` to start MySQL cluster
- Set up asynchronous Replication
  - get binlog status in the master using command `SHOW MASTER STATUS`, you should save `File` and `Position` for the next command
  - run command in the slave to configure replication
    ```sql
    CHANGE REPLICATION SOURCE TO
	SOURCE_HOST='<host>',
	SOURCE_USER='<user>',
	SOURCE_PASSWORD='<password>',
	SOURCE_LOG_FILE='<binlog file>',
	SOURCE_LOG_POS=<binlog position>;
    ```
  - start replication in the slave `START REPLICA` and get status `SHOW REPLICA STATUS`
- Install plugin in master `INSTALL PLUGIN rpl_semi_sync_source SONAME 'semisync_source.so';` and in slave `INSTALL PLUGIN rpl_semi_sync_replica SONAME 'semisync_replica.so'`
- Enable semi-synchronous replication in master `SET GLOBAL rpl_semi_sync_source_enabled = 1;` and in slave `SET GLOBAL rpl_semi_sync_replica_enabled = 1`
- Restart replication `STOP REPLICA IO_THREAD;` and `START REPLICA IO_THREAD;`
- Show status `SHOW STATUS LIKE 'Rpl_semi_sync%';`
- Test replication
  - Stop & start replication to make sure the replication works
