/**
 * Script for cleaning up the schema for PostgreSQL used for the AccountsDb plugin.
 */

DROP TABLE monitoring CASCADE;
DROP TABLE slot CASCADE;
DROP TABLE account_write CASCADE;
DROP TABLE pubkey CASCADE;
DROP TYPE "SlotStatus";

DROP TABLE euro_meta_write CASCADE;
DROP TABLE expiration_data_write CASCADE;
