

                                                                                --*************************
                                                                                -- REGEX FOUNDATION (BASICS)
                                                                                 --*************************

----------------------------------------------------
-- 1. Extract digits
----------------------------------------------------
-- Input: 123ABc
-- Regex: [0-9]
-- Meaning: matches any single digit (0-9)

----------------------------------------------------
-- 2. Extract alphabets
----------------------------------------------------
-- Input: 123ABc
-- Regex: [A-Za-z]
-- Meaning:
-- [A-Z] → uppercase letters
-- [a-z] → lowercase letters
-- [A-Za-z] → both

----------------------------------------------------
-- 3. ^ (start of string)
----------------------------------------------------
-- Regex: ^[0-9]
-- Meaning: string must start with digit
-- Example:
-- 123abc → 1
-- abc123 → no match

----------------------------------------------------
-- 4. $ (end of string)
----------------------------------------------------
-- Regex: [0-9]$
-- Meaning: string must end with digit
-- Example:
-- abc123 → 3

----------------------------------------------------
-- 5. Exact match using { }
----------------------------------------------------
-- Regex: [0-9]{2}
-- Meaning: exactly 2 digits
-- Input: 123456 → 12

-- Regex: [a-zA-Z]{2}
-- Meaning: exactly 2 letters
-- Input: abc123 → ab

----------------------------------------------------
-- 6. + (one or more)
----------------------------------------------------
-- Regex: [0-9]+ → continuous digits
-- Regex: [a-zA-Z]+ → continuous alphabets

----------------------------------------------------
-- 7. Continuity principle
----------------------------------------------------
-- Regex matches continuous characters only
-- Stops when pattern breaks

-- Example:
-- Input: 123abc567
-- Regex: [0-9]+ → 123

----------------------------------------------------
-- 7(a). Combined pattern
----------------------------------------------------
-- Regex: [0-9a-zA-Z]+
-- Matches full alphanumeric string

----------------------------------------------------
-- 8. Email extraction basics
----------------------------------------------------
-- Input: karthik@gmail.com

-- Domain part:
-- Regex: @[a-zA-Z.]+ → @gmail.com

-- Extension:
-- Regex: \.[a-zA-Z]+$ → .com

----------------------------------------------------
-- 9. Reserved characters
----------------------------------------------------
-- Characters: + . ^ $
-- Must be escaped using \

-- Example phone:
-- Input: +91-9989454737
-- Regex: \+91-[0-9]{10}

----------------------------------------------------
-- 10. Remove @ using REPLACE
----------------------------------------------------
-- REPLACE(
--   REGEXP_SUBSTR(email, '@[a-zA-Z.]+'),
--   '@',
--   ''
-- )

----------------------------------------------------
-- 11. Email structure (IMPORTANT)
----------------------------------------------------
-- username @ domain . extension

-- Username:
-- [a-zA-Z0-9._-]+

-- Domain:
-- [a-zA-Z0-9]+

-- Extension:
-- [a-zA-Z]{2,3}

-- Final Email Regex:
-- [a-zA-Z0-9._-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,3}

----------------------------------------------------
-- END OF REGEX FOUNDATION NOTES
----------------------------------------------------
