ALTER TABLE appl_score_sample ADD COLUMN "CI" NUMERIC;
ALTER TABLE appl_score_sample ADD COLUMN "CI_ln" NUMERIC;

UPDATE appl_score_sample
SET "CI" = "DCI" + "UCI",
    "CI_ln" = CASE WHEN ("DCI" + "UCI") > 0 THEN LOG("DCI" + "UCI") ELSE NULL END;
