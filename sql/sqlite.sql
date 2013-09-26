drop table if exists sessions;
CREATE TABLE sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);
drop table if exists member;
CREATE TABLE IF NOT EXISTS member (
    id           INTEGER NOT NULL PRIMARY KEY,
    name         VARCHAR(255)
);

drop table if exists entry;
create table if not exists entry (
    id integer not null primary key autoincrement,
    body text
);
