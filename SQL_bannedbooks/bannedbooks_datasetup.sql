CREATE TABLE countries (
    country_id   INT PRIMARY KEY,
    country_name VARCHAR(100),
    region       VARCHAR(80)
);

CREATE TABLE authors (
    author_id   INT PRIMARY KEY,
    author_name VARCHAR(120),
    nationality VARCHAR(80)
);

CREATE TABLE books (
    book_id        INT PRIMARY KEY,
    title          VARCHAR(200),
    author_id      INT REFERENCES authors(author_id),
    published_year INT,
    genre          VARCHAR(60)
);

CREATE TABLE bans (
    ban_id      INT PRIMARY KEY,
    book_id     INT REFERENCES books(book_id),
    country_id  INT REFERENCES countries(country_id),
    ban_year    INT,
    lifted_year INT,        -- NULL means the ban is still active
    reason      VARCHAR(200),
    severity    VARCHAR(20)
);


INSERT INTO countries VALUES
(1, 'United States', 'North America'),
(2, 'Russia',        'Europe'),
(3, 'China',         'Asia'),
(4, 'Iran',          'Middle East'),
(5, 'Turkey',        'Europe');

INSERT INTO authors VALUES
(1, 'George Orwell',    'British'),
(2, 'Anthony Burgess',  'British'),
(3, 'Stephen King',     'American'),
(4, 'John Green',       'American'),
(5, 'Judy Blume',       'American');

INSERT INTO books VALUES
(1, 'Animal Farm',                  1, 1945, 'Political Satire'),
(2, 'Nineteen Eighty-Four',         1, 1949, 'Dystopian Fiction'),
(3, 'A Clockwork Orange',           2, 1962, 'Dystopian Fiction'),
(4, 'It',                           3, 1986, 'Horror'),
(5, 'Looking for Alaska',           4, 2005, 'Young Adult'),
(6, 'Forever',                      5, 1975, 'Young Adult'),
(7, 'The Stand',                    3, 1978, 'Horror');

INSERT INTO bans VALUES
(1,  1, 2, 1945, 1990, 'Anti-Soviet propaganda',              'full'),
(2,  1, 3, 1949, NULL, 'Anti-communist themes',               'full'),
(3,  1, 4, 1980, NULL, 'Blasphemous content',                 'full'),
(4,  2, 3, 1990, NULL, 'Anti-authoritarian themes',           'full'),
(5,  2, 4, 1991, NULL, 'Subversive political content',        'restricted'),
(6,  3, 2, 2014, NULL, 'Glorification of violence',           'restricted'),
(7,  3, 1, 2025, NULL, 'Violence and sexual content',         'restricted'),
(8,  4, 2, 2019, NULL, 'LGBTQ+ content',                      'full'),
(9,  4, 1, 2025, NULL, 'Violence and graphic horror',         'advisory'),
(10, 5, 1, 2025, NULL, 'Drug references and sexual content',  'restricted'),
(11, 6, 1, 2025, NULL, 'Sexual content',                      'restricted'),
(12, 6, 1, 1976, 1990, 'Sexually explicit for minors',        'restricted'),
(13, 7, 1, 2025, NULL, 'Violence and occult themes',          'advisory');


