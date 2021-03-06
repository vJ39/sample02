CREATE TABLE sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data LONGBLOB
);
CREATE TABLE IF NOT EXISTS member (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(255)
);

create table if not exists entry (
    id int unsigned not null primary key auto_increment,
    body mediumtext
);
