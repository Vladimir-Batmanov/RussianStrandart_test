CREATE TABLE mean_ci_by_education AS
SELECT "EDUCATION", AVG("CI") AS "MEAN_CI"
FROM appl_score_sample
GROUP BY "EDUCATION";
