/* Formatted on 2012/05/22 21:22 (Formatter Plus v4.8.8) */
DECLARE
   v_line                 VARCHAR2 (2000);  -- Data line read from input file
   v_file                 UTL_FILE.file_type;             -- Data file handle
   v_dir                  VARCHAR2 (250)               := 'INTERFACE_OUT_CHP';
   -- Directory containing the data file
   v_filename             VARCHAR2 (50);                     -- Data filename
   v_1st_comma            NUMBER;
   v_2nd_comma            NUMBER;
   v_3rd_comma            NUMBER;
   v_4th_comma            NUMBER;
   v_5th_comma            NUMBER;
   v_6th_comma            NUMBER;
   v_7th_comma            NUMBER;
   v_8th_comma            NUMBER;
   v_9th_comma            NUMBER;
   v_10th_comma           NUMBER;
   v_11th_comma           NUMBER;
   v_12th_comma           NUMBER;
   v_record_id            xx.xxfpd_na_translation_recs.record_id%TYPE;
   v_translation_id       xx.xxfpd_na_translation_recs.translation_id%TYPE;
   v_record_number        xx.xxfpd_na_translation_recs.record_number%TYPE;
   v_enabled_flag         xx.xxfpd_na_translation_recs.enabled_flag%TYPE;
   v_language             xx.xxfpd_na_translation_recs.LANGUAGE%TYPE;
   v_start_date           xx.xxfpd_na_translation_recs.start_date%TYPE;
   v_end_date             xx.xxfpd_na_translation_recs.end_date%TYPE;
   v_created_by           xx.xxfpd_na_translation_recs.created_by%TYPE;
   v_creation_date        xx.xxfpd_na_translation_recs.creation_date%TYPE;
   v_last_updated_by      xx.xxfpd_na_translation_recs.last_updated_by%TYPE;
   v_last_update_date     xx.xxfpd_na_translation_recs.last_update_date%TYPE;
   v_last_update_login    xx.xxfpd_na_translation_recs.last_update_login%TYPE;
   v_precedence           xx.xxfpd_na_translation_recs.precedence%TYPE;
   v_created_by_val       xx.xxfpd_na_translation_values.created_by%TYPE;
   v_source_target_flag   xx.xxfpd_na_translation_values.source_target_flag%TYPE;
   v_attribute_number     xx.xxfpd_na_translation_values.attribute_number%TYPE;
   v_translation_value    xx.xxfpd_na_translation_values.translation_value%TYPE;
BEGIN

   BEGIN
      -- v_dir := 'INTERFACE_OUT_CHP';
      v_filename := 'XXFPD_NA_TRANSLATION_RECS.txt';
      v_file := UTL_FILE.fopen (v_dir, v_filename, 'r');

-- --------------------------------------------------------

      -- Loop over the file, reading in each line. GET_LINE will

      -- raise NO_DATA_FOUND when it is done, so we use that as

      -- the exit condition for the loop.

      -- --------------------------------------------------------
      LOOP
         BEGIN
            UTL_FILE.get_line (v_file, v_line);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               EXIT;
         END;

-- ----------------------------------------------------------

         -- Each field in the input record is delimited by commas. We

         -- need to find the locations of the two commas in the line,

         -- and use these locations to get the fields from v_line.

         -- ----------------------------------------------------------
         v_1st_comma := INSTR (v_line, '|', 1, 1);
         v_2nd_comma := INSTR (v_line, '|', 1, 2);
         v_3rd_comma := INSTR (v_line, '|', 1, 3);
         v_4th_comma := INSTR (v_line, '|', 1, 4);
         v_5th_comma := INSTR (v_line, '|', 1, 5);
         v_6th_comma := INSTR (v_line, '|', 1, 6);
         v_7th_comma := INSTR (v_line, '|', 1, 7);
         v_8th_comma := INSTR (v_line, '|', 1, 8);
         v_9th_comma := INSTR (v_line, '|', 1, 9);
         v_10th_comma := INSTR (v_line, '|', 1, 10);
         v_11th_comma := INSTR (v_line, '|', 1, 11);
         v_12th_comma := INSTR (v_line, '|', 1, 12);

         SELECT xx.xxfpd_na_transl_record_id_s.NEXTVAL
           INTO v_record_id
           FROM DUAL;

         -- v_record_id := TO_NUMBER (SUBSTR (v_line, 1, (v_1st_comma - 1)));
         v_translation_id :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_1st_comma + 1),
                               (v_2nd_comma - v_1st_comma - 1
                               )
                              )
                      );
         v_record_number :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_2nd_comma + 1),
                               (v_3rd_comma - v_2nd_comma - 1
                               )
                              )
                      );
         v_enabled_flag :=
            SUBSTR (v_line,
                    (v_3rd_comma + 1),
                    (v_4th_comma - v_3rd_comma - 1)
                   );
         v_language :=
            SUBSTR (v_line,
                    (v_4th_comma + 1),
                    (v_5th_comma - v_4th_comma - 1)
                   );
         v_start_date :=
            TO_DATE (SUBSTR (v_line,
                             (v_5th_comma + 1),
                             (v_6th_comma - v_5th_comma - 1
                             )
                            ),
                     'DD-MON-YYYY'
                    );
         v_end_date :=
            TO_DATE (SUBSTR (v_line,
                             (v_6th_comma + 1),
                             (v_7th_comma - v_6th_comma - 1
                             )
                            ),
                     'DD-MON-YYYY'
                    );
         v_created_by :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_7th_comma + 1),
                               (v_8th_comma - v_7th_comma - 1
                               )
                              )
                      );
         v_creation_date :=
            TO_DATE (SUBSTR (v_line,
                             (v_8th_comma + 1),
                             (v_9th_comma - v_8th_comma - 1
                             )
                            ),
                     'DD-MON-YYYY'
                    );
         v_last_updated_by :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_9th_comma + 1),
                               (v_10th_comma - v_9th_comma - 1
                               )
                              )
                      );
         v_last_update_date :=
            TO_DATE (SUBSTR (v_line,
                             (v_10th_comma + 1),
                             (v_11th_comma - v_10th_comma - 1
                             )
                            ),
                     'DD-MON-YYYY'
                    );
         v_last_update_login :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_11th_comma + 1),
                               (v_12th_comma - v_11th_comma - 1
                               )
                              )
                      );
         v_precedence :=
                      TO_NUMBER (SUBSTR (v_line, (v_12th_comma + 1), '99999'));

-- ------------------------------------------

         -- Insert the new record into the xxfpd_na_translation_recs table.

         -- ------------------------------------------
         INSERT INTO xx.xxfpd_na_translation_recs
              VALUES (v_record_id, v_translation_id, v_record_number,
                      v_enabled_flag, v_language, v_start_date, v_end_date,
                      v_created_by, v_creation_date, v_last_updated_by,
                      v_last_update_date, v_last_update_login, v_precedence);
      END LOOP;

      UTL_FILE.fclose (v_file);
      COMMIT;
   END;

   v_translation_id := NULL;
   v_record_number := NULL;
   v_created_by := NULL;
   v_creation_date := NULL;
   v_last_updated_by := NULL;
   v_last_update_date := NULL;
   v_last_update_login := NULL;

   BEGIN
      -- v_dir := 'INTERFACE_OUT_CHP';
      v_filename := 'XXFPD_NA_TRANSLATION_VALUES.txt';
      v_file := UTL_FILE.fopen (v_dir, v_filename, 'r');

-- --------------------------------------------------------

      -- Loop over the file, reading in each line. GET_LINE will

      -- raise NO_DATA_FOUND when it is done, so we use that as

      -- the exit condition for the loop.

      -- --------------------------------------------------------
      LOOP
         BEGIN
            UTL_FILE.get_line (v_file, v_line);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               EXIT;
         END;

-- ----------------------------------------------------------

         -- Each field in the input record is delimited by commas. We

         -- need to find the locations of the two commas in the line,

         -- and use these locations to get the fields from v_line.

         -- ----------------------------------------------------------
         v_1st_comma := INSTR (v_line, '|', 1, 1);
         v_2nd_comma := INSTR (v_line, '|', 1, 2);
         v_3rd_comma := INSTR (v_line, '|', 1, 3);
         v_4th_comma := INSTR (v_line, '|', 1, 4);
         v_5th_comma := INSTR (v_line, '|', 1, 5);
         v_6th_comma := INSTR (v_line, '|', 1, 6);
         v_7th_comma := INSTR (v_line, '|', 1, 7);
         v_8th_comma := INSTR (v_line, '|', 1, 8);
         v_9th_comma := INSTR (v_line, '|', 1, 9);
         v_10th_comma := INSTR (v_line, '|', 1, 10);
         v_11th_comma := INSTR (v_line, '|', 1, 11);
         v_12th_comma := INSTR (v_line, '|', 1, 12);
         v_translation_id := TO_NUMBER (SUBSTR (v_line, 1, (v_1st_comma - 1)));
         v_record_number :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_1st_comma + 1),
                               (v_2nd_comma - v_1st_comma - 1
                               )
                              )
                      );
         v_source_target_flag :=
            SUBSTR (v_line,
                    (v_2nd_comma + 1),
                    (v_3rd_comma - v_2nd_comma - 1)
                   );
         v_attribute_number :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_3rd_comma + 1),
                               (v_4th_comma - v_3rd_comma - 1
                               )
                              )
                      );
         v_translation_value :=
            SUBSTR (v_line,
                    (v_4th_comma + 1),
                    (v_5th_comma - v_4th_comma - 1));
         
         
--         select TO_NUMBER((SUBSTR (v_line,
--                               (v_5th_comma + 1),
--                               (v_6th_comma - v_5th_comma - 1
--                               )
--                              )))* 1 into v_created_by_val from  dual;
        
        v_created_by_val := 
            TO_NUMBER( SUBSTR (v_line,
                               (v_5th_comma + 1),
                               (v_6th_comma - v_5th_comma - 1
                               )
                              )) ;
        

 v_creation_date := TRUNC(SYSDATE);
--            TO_DATE (SUBSTR (v_line,
--                             (v_6th_comma + 1),
--                             (v_7th_comma - v_6th_comma - 1
--                             )
--                            ),
--                     'DD-MON-YYYY'
--                    );
         v_last_updated_by :=
            TO_NUMBER (SUBSTR (v_line,
                               (v_7th_comma + 1),
                               (v_8th_comma - v_7th_comma - 1
                               )
                              )
                      );
         v_last_update_date :=TRUNC(SYSDATE);
--            TO_DATE (SUBSTR (v_line,
--                             (v_8th_comma + 1),
--                             (v_9th_comma - v_8th_comma - 1
--                             )
--                            ),
--                     'DD-MON-YYYY'
--                    );
         v_last_update_login :=
                          TO_NUMBER (SUBSTR (v_line, (v_9th_comma + 1), '99999'));

-- ------------------------------------------

         -- Insert the new record into the xxfpd_na_translation_values table.

         -- ------------------------------------------
         INSERT INTO xx.xxfpd_na_translation_values
              VALUES (v_translation_id, v_record_number, v_source_target_flag,
                      v_attribute_number, v_translation_value,
                      v_created_by_val, v_creation_date, v_last_updated_by,
                      v_last_update_date, v_last_update_login);
      END LOOP;

      UTL_FILE.fclose (v_file);
      COMMIT;
   END;
END;