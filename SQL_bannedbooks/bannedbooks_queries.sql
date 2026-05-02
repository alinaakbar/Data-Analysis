--show each ban with the book title
SELECT bans.ban_id,
       books.title,
       bans.ban_year,
       bans.severity
FROM bans
JOIN books ON bans.book_id = books.book_id;

--join tables:ban,book,country
SELECT books.title,
       countries.country_name,
       bans.ban_year,
       bans.severity,
       bans.reason
FROM bans
JOIN books ON bans.book_id= books.book_id
JOIN countries ON bans.country_id = countries.country_id;

--join tables:ban,book,author,country
SELECT books.title,
       authors.author_name,
       countries.country_name,
       bans.ban_year,
       bans.severity
FROM bans
JOIN books ON bans.book_id = books.book_id
JOIN authors ON books.author_id = authors.author_id
JOIN countries ON bans.country_id = countries.country_id;

--label each ban as Ongoing, Recent, or Historic
SELECT books.title,
       countries.country_name,
       bans.ban_year,
       bans.lifted_year,
       CASE
           WHEN bans.lifted_year IS NULL THEN 'Ongoing'
           WHEN bans.lifted_year >= 2000 THEN 'Recent'
           ELSE 'Historic'
       END AS ban_status
FROM bans
JOIN books ON bans.book_id= books.book_id
JOIN countries ON bans.country_id=countries.country_id;


--— show books that are still banned
SELECT books.title,
       countries.country_name,
       bans.ban_year,
       COALESCE(bans.lifted_year::TEXT, 'Still banned') AS lifted_status
FROM bans
JOIN books     ON bans.book_id    = books.book_id
JOIN countries ON bans.country_id = countries.country_id;


-- Label whether the ban is Ongoing or lifted
SELECT books.title,
       countries.country_name,
       CASE WHEN bans.lifted_year IS NULL
            THEN 'Ongoing'
            ELSE 'Lifted'
       END AS ban_active
FROM bans
JOIN books ON bans.book_id = books.book_id
JOIN countries ON bans.country_id = countries.country_id;

--books banned in more than 1 country
SELECT title
FROM books
WHERE book_id IN (
    SELECT book_id
    FROM bans
    GROUP BY book_id
    HAVING COUNT(country_id)>1
);

--how many bans per country
SELECT countries.country_name,
       COUNT(bans.ban_id) AS total_bans
FROM bans
JOIN countries ON bans.country_id = countries.country_id
GROUP BY countries.country_name
ORDER BY total_bans DESC;

--lift the Animal Farm ban in China
UPDATE bans
SET lifted_year = 2025
WHERE ban_id = 2;

-- Verify
SELECT * FROM bans WHERE ban_id = 2;


