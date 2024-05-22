WITH credit_cards AS (
    SELECT 
        pass_ser, 
        pass_num
    FROM em_ag_tab_1_cards
    WHERE is_type = 2
    GROUP BY pass_ser, pass_num
    HAVING COUNT(cr_num) > 1
),
september_transactions AS (
    SELECT 
        c.pass_ser,
        c.pass_num,
        t.cr_num,
        t.date_tranz,
        t.buy_category,
        t.amount
    FROM em_ag_tab_1_cards c
    JOIN em_ag_tab_2_out_trunz t ON c.cr_num = t.cr_num
    WHERE t.date_tranz BETWEEN DATE '2019-09-01' AND DATE '2019-09-30'
),
categorized_transactions AS (
    SELECT 
        st.pass_ser,
        st.pass_num,
        st.cr_num,
        dc.name_category,
        st.amount
    FROM september_transactions st
    JOIN em_ag_tab_3_dict_category dc ON st.buy_category = dc.buy_category
),
aggregated_data AS (
    SELECT 
        ct.pass_ser,
        ct.pass_num,
        SUM(CASE WHEN ct.name_category = 'Алкоголь' THEN ct.amount ELSE 0 END) AS alcohol_spending,
        SUM(ct.amount) AS total_spending,
        SUM(CASE WHEN c.is_type = 2 THEN ct.amount ELSE 0 END) AS credit_card_spending,
        MAX(CASE WHEN ct.name_category = 'Путешествия' THEN ct.amount ELSE 0 END) AS max_travel_spending
    FROM categorized_transactions ct
    JOIN em_ag_tab_1_cards c ON ct.cr_num = c.cr_num
    GROUP BY ct.pass_ser, ct.pass_num
)
SELECT 
    pass_ser,
    pass_num,
    alcohol_spending,
    total_spending,
    credit_card_spending,
    max_travel_spending
FROM aggregated_data
ORDER BY alcohol_spending DESC, max_travel_spending ASC;
