-- TRIGGER:auto-log whenever a ban is inserted

CREATE TABLE IF NOT EXISTS ban_log (
    log_id SERIAL PRIMARY KEY,
    ban_id INT,
    logged_at TIMESTAMP DEFAULT NOW()
);


CREATE OR REPLACE FUNCTION log_new_ban()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO ban_log (ban_id, logged_at)
    VALUES (NEW.ban_id, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER after_ban_insert
AFTER INSERT ON bans
FOR EACH ROW
EXECUTE FUNCTION log_new_ban();

INSERT INTO bans VALUES (14, 2, 5, 2023, NULL, 'Anti-government themes', 'restricted');
SELECT * FROM ban_log;


