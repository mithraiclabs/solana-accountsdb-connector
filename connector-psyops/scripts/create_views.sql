-- Views for raw accounts
CREATE VIEW account_rooted AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        account_write.*
        FROM account_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW account_confirmed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        account_write.*
        FROM account_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND ((slot.status = 'Confirmed' AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW account_processed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        account_write.*
        FROM account_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (((slot.status = 'Confirmed' OR slot.status = 'Processed') AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
-- Views for PsyOptions Tokenized Euros related accounts
CREATE VIEW euro_meta_rooted AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        euro_meta_write.*
        FROM euro_meta_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW euro_meta_confirmed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        euro_meta_write.*
        FROM euro_meta_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND ((slot.status = 'Confirmed' AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW euro_meta_processed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        euro_meta_write.*
        FROM euro_meta_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (((slot.status = 'Confirmed' OR slot.status = 'Processed') AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;


CREATE VIEW expiration_data_rooted AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        expiration_data_write.*
        FROM expiration_data_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW expiration_data_confirmed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        expiration_data_write.*
        FROM expiration_data_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND ((slot.status = 'Confirmed' AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
CREATE VIEW expiration_data_processed AS
    SELECT pubkey, latest_writes.* FROM
        (SELECT
        DISTINCT ON(pubkey_id)
        expiration_data_write.*
        FROM expiration_data_write
        LEFT JOIN slot USING(slot)
        CROSS JOIN (SELECT max(slot) FROM slot) ms
        WHERE slot <= ms.max
        AND (((slot.status = 'Confirmed' OR slot.status = 'Processed') AND NOT slot.uncle) OR slot.status = 'Rooted' OR slot.status is NULL)
        ORDER BY pubkey_id, slot DESC, write_version DESC) latest_writes
    LEFT JOIN account_write USING(pubkey_id, slot, write_version)
    LEFT JOIN pubkey USING(pubkey_id)
    WHERE is_selected;
