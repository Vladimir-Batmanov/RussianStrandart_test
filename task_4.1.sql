CREATE TABLE subset_1 AS
SELECT "CLIENT_ID", "ACCOUNTS_FLAG"
FROM appl_score_sample
LIMIT 20;