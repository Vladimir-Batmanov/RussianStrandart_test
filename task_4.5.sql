WITH median_value AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "TRANSPORT_AMOUNT") AS median_transport_amount
    FROM appl_score_sample
    WHERE "TRANSPORT_AMOUNT" >= 0
)
UPDATE appl_score_sample
SET "TRANSPORT_AMOUNT" = (SELECT median_transport_amount FROM median_value)
WHERE "TRANSPORT_AMOUNT" < 0;

