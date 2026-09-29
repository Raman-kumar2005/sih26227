-- Auto-generated PostGIS seed data for SIH 2026
BEGIN;

INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.000000, -0.000708, -0.003685, 0.000708,
            1.0000, 0.0000, 0.2000, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.881, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.000000, 0.009876, -0.013666, -0.009876,
            0.3000, 0.0000, 0.6840, '{"quality": 0.3, "registration": 1.0, "seasonal": 0.881, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.000000, -0.007153, 0.004408, 0.007153,
            1.0000, 2.5000, 0.6390, '{"quality": 1.0, "registration": 0.0, "seasonal": 0.881, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 5.000000, 0.002946, 0.004157, -0.002946,
            1.0000, 0.0000, 0.9500, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.953, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 5.000000, 0.007965, 0.006848, -0.007965,
            1.0000, 0.0000, 0.9500, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.953, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 5.000000, -0.004544, 0.002377, 0.004544,
            1.0000, 0.0000, 0.9500, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.953, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.158426, -0.015198, -0.000894, 0.015198,
            0.9816, 0.0000, 0.7910, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.896, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.534869, -0.018585, 0.011578, 0.018585,
            0.9800, 0.0000, 0.7110, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.631, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.061051, 0.001813, -0.005054, -0.001813,
            1.0000, 0.0000, 0.5630, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.126, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.085120, 0.014915, -0.043788, -0.014915,
            0.9400, 0.0000, 0.6720, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.521, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.073165, -0.008163, 0.004523, 0.008163,
            0.9800, 0.0000, 0.5600, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.127, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.068540, -0.000613, 0.004329, 0.000613,
            0.9816, 0.0000, 0.5600, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.127, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.483925, 0.002049, -0.003711, -0.002049,
            0.9800, 0.0000, 0.6340, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.374, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.004741, 0.005062, -0.004741,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.051827, 0.019356, 0.051827,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.003810, 0.008278, 0.003810,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.000814, -0.002529, -0.000814,
            0.9816, 0.0000, 0.5580, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.628495, 0.006564, -0.008701, -0.006564,
            0.9800, 0.0000, 0.6440, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.408, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.006626, 0.007746, 0.006626,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.046997, 0.043993, -0.046997,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 3.931298, 0.013004, -0.005883, -0.013004,
            0.9800, 0.0000, 0.7840, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.873, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.548447, -0.020040, 0.019423, 0.020040,
            0.9816, 0.0000, 0.5790, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.19, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.135056, 0.012762, -0.002192, -0.012762,
            0.9800, 0.0000, 0.6110, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.296, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.006857, -0.005715, -0.006857,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.028665, 0.010176, 0.028665,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.221845, 0.000887, -0.004077, -0.000887,
            0.9800, 0.0000, 0.6160, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.315, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.012905, -0.014846, -0.012905,
            0.9816, 0.0000, 0.5580, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.751396, -0.006699, 0.004523, 0.006699,
            0.9800, 0.0000, 0.6530, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.438, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.007661, -0.001782, 0.007661,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.416613, -0.015066, -0.022813, 0.015066,
            0.9400, 0.0000, 0.5670, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.17, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.012460, -0.007593, -0.012460,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.704556, 0.008596, 0.008177, -0.008596,
            0.9816, 0.0000, 0.8030, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.937, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.973006, 0.005143, -0.000446, -0.005143,
            0.9800, 0.0000, 0.6010, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.264, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.007684, -0.014192, -0.007684,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.645090, -0.002793, -0.029179, 0.002793,
            0.9400, 0.0000, 0.7130, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.656, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.009126, 0.006061, 0.009126,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61883351207838 12.900649563849338, 77.64483351207838 12.900649563849338, 77.64483351207838 12.920649563849338, 77.61883351207838 12.920649563849338, 77.61883351207838 12.900649563849338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_0_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_0', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.417727, 0.003661, 0.000007, -0.003661,
            0.9816, 0.0000, 0.6300, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.358, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64479140155133 12.899091869841357, 77.67079140155133 12.899091869841357, 77.67079140155133 12.919091869841356, 77.64479140155133 12.919091869841356, 77.64479140155133 12.899091869841357))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.005919, -0.005458, -0.005919,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61881082953425 12.919869169505942, 77.64481082953425 12.919869169505942, 77.64481082953425 12.939869169505942, 77.61881082953425 12.939869169505942, 77.61881082953425 12.919869169505942))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/1_1_2026-09-04 13:02:19.531487', 'bangalore_lakes/1_1', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.009754, 0.009778, 0.009754,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.64695134580509 12.919137357844127, 77.67295134580509 12.919137357844127, 77.67295134580509 12.939137357844126, 77.64695134580509 12.939137357844126, 77.64695134580509 12.919137357844127))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'bangalore_lakes/0_2_2026-09-04 13:02:19.531487', 'bangalore_lakes/0_2', 'bangalore_lakes', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.393722, 0.028474, 0.015406, -0.028474,
            0.9400, 0.0000, 0.6220, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.353, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.61984810428467 12.939163462702606, 77.64584810428467 12.939163462702606, 77.64584810428467 12.959163462702605, 77.61984810428467 12.959163462702605, 77.61984810428467 12.939163462702606))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.476933, -0.013897, 0.003250, 0.013897,
            0.9800, 0.0000, 0.7070, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.617, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.342737, -0.000420, -0.006693, 0.000420,
            0.9816, 0.0000, 0.6250, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.341, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.768703, -0.014284, 0.006984, 0.014284,
            0.9800, 0.0000, 0.5900, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.226, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.397793, 0.003370, 0.004902, -0.003370,
            1.0000, 0.0000, 0.5750, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.168, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.019794, -0.048894, -0.019794,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.004322, 0.006057, -0.004322,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.078722, 0.008596, 0.013288, -0.008596,
            0.9816, 0.0000, 0.5610, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.128, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 3.114244, 0.004038, 0.010890, -0.004038,
            0.9800, 0.0000, 0.7480, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.753, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.687237, 0.003644, 0.002411, -0.003644,
            1.0000, 0.0000, 0.6520, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.422, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.000390, -0.002497, 0.000390,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.648168, 0.018504, -0.004763, -0.018504,
            0.9800, 0.0000, 0.6460, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.413, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.229835, 0.006757, -0.004136, -0.006757,
            0.9816, 0.0000, 0.5660, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.146, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.002583, -0.013591, 0.002583,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.223353, -0.013167, 0.010176, 0.013167,
            1.0000, 0.0000, 0.6920, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.556, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 3.061999, -0.023112, -0.011502, 0.023112,
            0.9400, 0.0000, 0.7390, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.743, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.862560, 0.001971, -0.011520, -0.001971,
            0.9800, 0.0000, 0.7330, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.703, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.009867, 0.009759, 0.009867,
            0.9816, 0.0000, 0.5580, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.381575, 0.011737, -0.006374, -0.011737,
            0.9800, 0.0000, 0.5720, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.165, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.662527, -0.008001, -0.004674, 0.008001,
            1.0000, 0.0000, 0.6500, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.416, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.951090, -0.044017, -0.030793, 0.044017,
            0.9400, 0.0000, 0.7320, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.721, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.041652, -0.006854, 0.002120, 0.006854,
            0.9800, 0.0000, 0.5590, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.124, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.628682, -0.007875, -0.005580, 0.007875,
            0.9816, 0.0000, 0.5830, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.202, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.002995, -0.001536, -0.002995,
            0.9800, 0.0000, 0.5580, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.007503, -0.019006, -0.007503,
            1.0000, 0.0000, 0.5610, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.625052, 0.019507, 0.012440, -0.019507,
            0.9400, 0.0000, 0.7110, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.651, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 3.712480, 0.005280, 0.008467, -0.005280,
            0.9800, 0.0000, 0.7760, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.847, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.855980, 0.001647, 0.001343, -0.001647,
            0.9816, 0.0000, 0.5950, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.242, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 3.007066, 0.004945, 0.001685, -0.004945,
            0.9800, 0.0000, 0.7420, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.732, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.723272, 0.010256, -0.002240, -0.010256,
            1.0000, 0.0000, 0.6540, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.431, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.014378, 0.041526, 0.014378,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.722791, -0.000298, -0.003871, 0.000298,
            0.9800, 0.0000, 0.6510, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.431, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.076073, 0.006585, -0.011551, -0.006585,
            0.9816, 0.0000, 0.7890, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.889, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.928348, 0.004579, -0.003983, -0.004579,
            0.9800, 0.0000, 0.5990, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.255, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 4.129287, -0.007886, 0.002895, 0.007886,
            1.0000, 0.0000, 0.7930, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.894, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, 0.071108, -0.026109, -0.071108,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_0_2026-09-04 13:02:19.531487', 'delhi_airport/0_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 2.643805, -0.009030, 0.000261, 0.009030,
            0.9800, 0.0000, 0.7190, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.656, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99009380831333 28.530478058944457, 77.01809380831334 28.530478058944457, 77.01809380831334 28.54797805894446, 76.99009380831333 28.54797805894446, 76.99009380831333 28.530478058944457))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_0_2026-09-04 13:02:19.531487', 'delhi_airport/1_0', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.174094, -0.005423, 0.003571, 0.005423,
            0.9816, 0.0000, 0.6140, '{"quality": 0.982, "registration": 1.0, "seasonal": 0.305, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.01878476487133 28.529976888135618, 77.04678476487133 28.529976888135618, 77.04678476487133 28.54747688813562, 77.01878476487133 28.54747688813562, 77.01878476487133 28.529976888135618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_1_2026-09-04 13:02:19.531487', 'delhi_airport/0_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.401985, -0.011427, 0.005925, 0.011427,
            0.9800, 0.0000, 0.5720, '{"quality": 0.98, "registration": 1.0, "seasonal": 0.168, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.9889716178071 28.54769838172366, 77.0169716178071 28.54769838172366, 77.0169716178071 28.56519838172366, 76.9889716178071 28.56519838172366, 76.9889716178071 28.54769838172366))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/1_1_2026-09-04 13:02:19.531487', 'delhi_airport/1_1', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 1.183522, 0.004280, 0.005535, -0.004280,
            1.0000, 0.0000, 0.6170, '{"quality": 1.0, "registration": 1.0, "seasonal": 0.307, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((77.0187371415147 28.54685253364348, 77.04673714151471 28.54685253364348, 77.04673714151471 28.56435253364348, 77.0187371415147 28.56435253364348, 77.0187371415147 28.54685253364348))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'delhi_airport/0_2_2026-09-04 13:02:19.531487', 'delhi_airport/0_2', 'delhi_airport', '2026-09-04 13:02:19.531487', 'monsoon_N=8', 'sentinel-2',
            0.000000, 0.000000, -0.028512, 0.065829, 0.028512,
            0.9400, 0.0000, 0.5520, '{"quality": 0.94, "registration": 1.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((76.99031099232991 28.565817098876792, 77.01831099232992 28.565817098876792, 77.01831099232992 28.58331709887679, 76.99031099232991 28.58331709887679, 76.99031099232991 28.565817098876792))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_0_2023-01-15 00:00:00.000000', 'assam_border/0_0', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.560656, 0.002701, 0.006891, -0.002701,
            0.9723, 0.3991, 0.3430, '{"quality": 0.972, "registration": 0.601, "seasonal": 0.192, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79963183617289 27.500595497506513, 91.8296318361729 27.500595497506513, 91.8296318361729 27.53809549750651, 91.79963183617289 27.53809549750651, 91.79963183617289 27.500595497506513))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_0_2023-01-15 00:00:00.000000', 'assam_border/1_0', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            0.000000, 1.714225, 0.000000, 0.000000, 0.000000,
            0.8578, 0.3979, 0.3980, '{"quality": 0.858, "registration": 0.602, "seasonal": 0.429, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.83112229137924 27.500004546770608, 91.86112229137925 27.500004546770608, 91.86112229137925 27.537504546770606, 91.83112229137924 27.537504546770606, 91.83112229137924 27.500004546770608))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_0_2023-01-15 00:00:00.000000', 'assam_border/3_0', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 3.955788, -0.003072, -0.001528, 0.003072,
            0.9967, 1.4714, 0.8120, '{"quality": 0.997, "registration": 0.0, "seasonal": 0.876, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.88927943964299 27.499562327951352, 91.91927943964299 27.499562327951352, 91.91927943964299 27.537062327951354, 91.88927943964299 27.537062327951354, 91.88927943964299 27.499562327951352))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_0_2023-01-15 00:00:00.000000', 'assam_border/4_0', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.013465, 0.009817, 0.013465,
            0.8572, 0.4622, 0.4700, '{"quality": 0.857, "registration": 0.538, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92015141368725 27.49832385512284, 91.95015141368725 27.49832385512284, 91.95015141368725 27.535823855122842, 91.92015141368725 27.535823855122842, 91.92015141368725 27.49832385512284))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_1_2023-01-15 00:00:00.000000', 'assam_border/0_1', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
            0.8614, 0.6378, 0.4440, '{"quality": 0.861, "registration": 0.362, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.7989626090158 27.538932628157657, 91.8289626090158 27.538932628157657, 91.8289626090158 27.576432628157654, 91.7989626090158 27.576432628157654, 91.7989626090158 27.538932628157657))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_1_2023-01-15 00:00:00.000000', 'assam_border/1_1', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.000402, -0.002126, 0.000402,
            0.9605, 0.3241, 0.3310, '{"quality": 0.96, "registration": 0.676, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8304327560763 27.53586086731146, 91.8604327560763 27.53586086731146, 91.8604327560763 27.573360867311457, 91.8304327560763 27.573360867311457, 91.8304327560763 27.53586086731146))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_1_2023-01-15 00:00:00.000000', 'assam_border/2_1', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            0.000000, 2.830804, 0.000000, 0.000000, 0.000000,
            0.9472, 0.4248, 0.6620, '{"quality": 0.947, "registration": 0.575, "seasonal": 0.697, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.86015139209465 27.53573483080833, 91.89015139209465 27.53573483080833, 91.89015139209465 27.57323483080833, 91.86015139209465 27.57323483080833, 91.86015139209465 27.53573483080833))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_1_2023-01-15 00:00:00.000000', 'assam_border/3_1', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.657502, 0.001560, -0.003989, -0.001560,
            0.8884, 0.5515, 0.7250, '{"quality": 0.888, "registration": 0.449, "seasonal": 0.415, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89025134552348 27.53881232758893, 91.92025134552348 27.53881232758893, 91.92025134552348 27.57631232758893, 91.89025134552348 27.57631232758893, 91.89025134552348 27.53881232758893))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_1_2023-01-15 00:00:00.000000', 'assam_border/4_1', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            -0.000000, 0.000000, -0.001013, 0.000945, 0.001013,
            0.8020, 1.4987, 0.2060, '{"quality": 0.802, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92027044459867 27.535708924234232, 91.95027044459867 27.535708924234232, 91.95027044459867 27.57320892423423, 91.92027044459867 27.57320892423423, 91.92027044459867 27.535708924234232))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_2_2023-01-15 00:00:00.000000', 'assam_border/0_2', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 2.026535, 0.001068, 0.003883, -0.001068,
            0.8360, 0.0568, 0.6440, '{"quality": 0.836, "registration": 0.943, "seasonal": 0.507, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.80133069595753 27.574211767678854, 91.83133069595753 27.574211767678854, 91.83133069595753 27.611711767678855, 91.80133069595753 27.611711767678855, 91.80133069595753 27.574211767678854))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_2_2023-01-15 00:00:00.000000', 'assam_border/1_2', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.194155, -0.000996, 0.002837, 0.000996,
            0.9282, 0.7252, 0.4980, '{"quality": 0.928, "registration": 0.275, "seasonal": 0.309, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8293580033751 27.57418239822501, 91.8593580033751 27.57418239822501, 91.8593580033751 27.611682398225007, 91.8293580033751 27.611682398225007, 91.8293580033751 27.57418239822501))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_2_2023-01-15 00:00:00.000000', 'assam_border/2_2', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 2.937290, -0.015338, 0.006446, 0.015338,
            0.8968, 0.8119, 0.4280, '{"quality": 0.897, "registration": 0.188, "seasonal": 0.719, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8599314388428 27.574715959438983, 91.88993143884281 27.574715959438983, 91.88993143884281 27.612215959438984, 91.8599314388428 27.612215959438984, 91.8599314388428 27.574715959438983))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_2_2023-01-15 00:00:00.000000', 'assam_border/3_2', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            -0.000000, 0.000000, -0.003478, 0.005819, 0.003478,
            0.9713, 1.4387, 0.2310, '{"quality": 0.971, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89122793105305 27.57471597699949, 91.92122793105305 27.57471597699949, 91.92122793105305 27.612215976999487, 91.89122793105305 27.612215976999487, 91.89122793105305 27.57471597699949))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_2_2023-01-15 00:00:00.000000', 'assam_border/4_2', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.344676, -0.006757, 0.001485, 0.006757,
            0.8785, 0.2660, 0.3400, '{"quality": 0.879, "registration": 0.734, "seasonal": 0.16, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91997519701503 27.57360242051144, 91.94997519701504 27.57360242051144, 91.94997519701504 27.611102420511436, 91.91997519701503 27.611102420511436, 91.91997519701503 27.57360242051144))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_3_2023-01-15 00:00:00.000000', 'assam_border/0_3', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            0.000000, 0.215784, 0.000000, 0.000000, 0.000000,
            0.9158, 1.2487, 0.2310, '{"quality": 0.916, "registration": 0.0, "seasonal": 0.144, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79977652208682 27.613110761880126, 91.82977652208682 27.613110761880126, 91.82977652208682 27.650610761880124, 91.79977652208682 27.650610761880124, 91.79977652208682 27.613110761880126))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_3_2023-01-15 00:00:00.000000', 'assam_border/1_3', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
            0.9591, 0.4557, 0.4860, '{"quality": 0.959, "registration": 0.544, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82919548230959 27.614055212257913, 91.85919548230959 27.614055212257913, 91.85919548230959 27.65155521225791, 91.82919548230959 27.65155521225791, 91.82919548230959 27.614055212257913))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_3_2023-01-15 00:00:00.000000', 'assam_border/2_3', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.592241, 0.001277, 0.000617, -0.001277,
            0.9501, 0.3947, 0.4030, '{"quality": 0.95, "registration": 0.605, "seasonal": 0.399, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85890236656344 27.613124404156594, 91.88890236656344 27.613124404156594, 91.88890236656344 27.650624404156595, 91.85890236656344 27.650624404156595, 91.85890236656344 27.613124404156594))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_3_2023-01-15 00:00:00.000000', 'assam_border/3_3', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.522111, -0.002120, 0.003265, 0.002120,
            0.9444, 0.6011, 0.3660, '{"quality": 0.944, "registration": 0.399, "seasonal": 0.383, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89028267651477 27.613026745761974, 91.92028267651477 27.613026745761974, 91.92028267651477 27.650526745761972, 91.89028267651477 27.650526745761972, 91.89028267651477 27.613026745761974))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_3_2023-01-15 00:00:00.000000', 'assam_border/4_3', 'assam_border', '2023-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.010227, 0.007159, -0.001472, -0.007159,
            0.8563, 0.3052, 0.3640, '{"quality": 0.856, "registration": 0.695, "seasonal": 0.271, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92128909070809 27.610974324536787, 91.95128909070809 27.610974324536787, 91.95128909070809 27.648474324536785, 91.92128909070809 27.648474324536785, 91.92128909070809 27.610974324536787))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_0_2023-06-15 00:00:00.000000', 'assam_border/0_0', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.530826, -0.007719, 0.000567, 0.007719,
            0.9179, 0.4394, 0.3280, '{"quality": 0.918, "registration": 0.561, "seasonal": 0.187, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79959236378873 27.5014141596067, 91.82959236378873 27.5014141596067, 91.82959236378873 27.538914159606698, 91.79959236378873 27.538914159606698, 91.79959236378873 27.5014141596067))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_0_2023-06-15 00:00:00.000000', 'assam_border/1_0', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.001421, 0.004098, 0.001421,
            0.9005, 0.7560, 0.4320, '{"quality": 0.9, "registration": 0.244, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.83120456301147 27.498651593796964, 91.86120456301147 27.498651593796964, 91.86120456301147 27.536151593796966, 91.83120456301147 27.536151593796966, 91.83120456301147 27.498651593796964))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_0_2023-06-15 00:00:00.000000', 'assam_border/2_0', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            -0.000000, 0.158590, 0.010854, -0.007298, -0.010854,
            0.8191, 1.1418, 0.3890, '{"quality": 0.819, "registration": 0.0, "seasonal": 0.137, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85969098061787 27.49884776136252, 91.88969098061787 27.49884776136252, 91.88969098061787 27.53634776136252, 91.85969098061787 27.53634776136252, 91.85969098061787 27.49884776136252))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_0_2023-06-15 00:00:00.000000', 'assam_border/4_0', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.314571, 0.004766, -0.001836, -0.004766,
            0.8432, 1.0600, 0.3980, '{"quality": 0.843, "registration": 0.0, "seasonal": 0.156, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91991021493547 27.49853012583603, 91.94991021493547 27.49853012583603, 91.94991021493547 27.536030125836028, 91.91991021493547 27.536030125836028, 91.91991021493547 27.49853012583603))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_1_2023-06-15 00:00:00.000000', 'assam_border/0_1', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=1', 'sentinel-2',
            0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
            0.9348, 0.9540, 0.4080, '{"quality": 0.935, "registration": 0.046, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8006333902973 27.539151785775193, 91.83063339029731 27.539151785775193, 91.83063339029731 27.57665178577519, 91.8006333902973 27.57665178577519, 91.8006333902973 27.539151785775193))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_1_2023-06-15 00:00:00.000000', 'assam_border/1_1', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.677429, 0.001682, -0.003933, -0.001682,
            0.9206, 1.1630, 0.2510, '{"quality": 0.921, "registration": 0.0, "seasonal": 0.21, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82978828351162 27.537211073441842, 91.85978828351162 27.537211073441842, 91.85978828351162 27.57471107344184, 91.82978828351162 27.57471107344184, 91.82978828351162 27.537211073441842))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_1_2023-06-15 00:00:00.000000', 'assam_border/2_1', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.808102, -0.000593, 0.006983, 0.000593,
            0.9337, 0.6876, 0.5480, '{"quality": 0.934, "registration": 0.312, "seasonal": 0.452, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85916454488913 27.535766975928333, 91.88916454488913 27.535766975928333, 91.88916454488913 27.573266975928334, 91.85916454488913 27.573266975928334, 91.85916454488913 27.535766975928333))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_1_2023-06-15 00:00:00.000000', 'assam_border/3_1', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 4.772372, 0.003401, 0.006761, -0.003401,
            0.9532, 0.9845, 0.6530, '{"quality": 0.953, "registration": 0.016, "seasonal": 0.941, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89017296560796 27.53635613330883, 91.92017296560796 27.53635613330883, 91.92017296560796 27.57385613330883, 91.89017296560796 27.57385613330883, 91.89017296560796 27.53635613330883))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_1_2023-06-15 00:00:00.000000', 'assam_border/4_1', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            -0.000000, 1.349036, 0.008052, 0.005105, -0.008052,
            0.9091, 0.1375, 0.4190, '{"quality": 0.909, "registration": 0.863, "seasonal": 0.343, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92085603537882 27.537860734477462, 91.95085603537882 27.537860734477462, 91.95085603537882 27.575360734477464, 91.92085603537882 27.575360734477464, 91.92085603537882 27.537860734477462))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_2_2023-06-15 00:00:00.000000', 'assam_border/0_2', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.515101, 0.001036, -0.008231, -0.001036,
            0.9771, 0.6503, 0.7130, '{"quality": 0.977, "registration": 0.35, "seasonal": 0.381, "radiometric": 1.0, "persistence": 1.0, "persistence_status": "confirmed_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.80040566486393 27.576286984468744, 91.83040566486393 27.576286984468744, 91.83040566486393 27.613786984468746, 91.80040566486393 27.613786984468746, 91.80040566486393 27.576286984468744))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_2_2023-06-15 00:00:00.000000', 'assam_border/1_2', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.851108, 0.004364, 0.003686, -0.004364,
            0.9398, 0.5598, 0.5040, '{"quality": 0.94, "registration": 0.44, "seasonal": 0.241, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82976438593775 27.57555588317077, 91.85976438593775 27.57555588317077, 91.85976438593775 27.613055883170773, 91.82976438593775 27.613055883170773, 91.82976438593775 27.57555588317077))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_2_2023-06-15 00:00:00.000000', 'assam_border/2_2', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.006179, -0.000096, 0.006179,
            0.8473, 0.7050, 0.2570, '{"quality": 0.847, "registration": 0.295, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85960323647795 27.57599349444618, 91.88960323647795 27.57599349444618, 91.88960323647795 27.613493494446182, 91.85960323647795 27.613493494446182, 91.85960323647795 27.57599349444618))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_2_2023-06-15 00:00:00.000000', 'assam_border/4_2', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.946972, -0.000704, 0.013424, 0.000704,
            0.9284, 0.9857, 0.4440, '{"quality": 0.928, "registration": 0.014, "seasonal": 0.259, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.9190230917825 27.573498130500504, 91.94902309178251 27.573498130500504, 91.94902309178251 27.610998130500505, 91.9190230917825 27.610998130500505, 91.9190230917825 27.573498130500504))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_3_2023-06-15 00:00:00.000000', 'assam_border/0_3', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.120460, 0.006614, 0.002877, -0.006614,
            0.9586, 0.9038, 0.4710, '{"quality": 0.959, "registration": 0.096, "seasonal": 0.293, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.7996520138236 27.613428530638338, 91.8296520138236 27.613428530638338, 91.8296520138236 27.65092853063834, 91.7996520138236 27.65092853063834, 91.7996520138236 27.613428530638338))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_3_2023-06-15 00:00:00.000000', 'assam_border/1_3', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 5.926484, -0.002839, 0.002018, 0.002839,
            0.8822, 0.7634, 0.6870, '{"quality": 0.882, "registration": 0.237, "seasonal": 0.981, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82966112958368 27.612218321558988, 91.85966112958369 27.612218321558988, 91.85966112958369 27.649718321558986, 91.82966112958368 27.649718321558986, 91.82966112958368 27.612218321558988))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_3_2023-06-15 00:00:00.000000', 'assam_border/2_3', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.615278, 0.010605, -0.009392, -0.010605,
            0.9908, 0.2273, 0.5500, '{"quality": 0.991, "registration": 0.773, "seasonal": 0.2, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "partially_persistent", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.86108441379835 27.612864321893298, 91.89108441379835 27.612864321893298, 91.89108441379835 27.6503643218933, 91.86108441379835 27.6503643218933, 91.86108441379835 27.612864321893298))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_3_2023-06-15 00:00:00.000000', 'assam_border/3_3', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=1', 'sentinel-2',
            0.000000, 1.603095, 0.000000, 0.000000, 0.000000,
            0.9519, 0.7427, 0.5270, '{"quality": 0.952, "registration": 0.257, "seasonal": 0.402, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89021949360789 27.613064058443992, 91.92021949360789 27.613064058443992, 91.92021949360789 27.65056405844399, 91.89021949360789 27.65056405844399, 91.89021949360789 27.613064058443992))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_3_2023-06-15 00:00:00.000000', 'assam_border/4_3', 'assam_border', '2023-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.930576, 0.007567, -0.006287, -0.007567,
            0.9122, 0.4338, 0.3480, '{"quality": 0.912, "registration": 0.566, "seasonal": 0.256, "radiometric": 1.0, "persistence": 0.0, "persistence_status": "transient_artefact", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91995777308644 27.61279648806154, 91.94995777308644 27.61279648806154, 91.94995777308644 27.650296488061542, 91.91995777308644 27.650296488061542, 91.91995777308644 27.61279648806154))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_0_2024-01-15 00:00:00.000000', 'assam_border/0_0', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.002701, -0.006891, 0.002701,
            0.8994, 0.0646, 0.5360, '{"quality": 0.899, "registration": 0.935, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79931465118933 27.50158821194666, 91.82931465118934 27.50158821194666, 91.82931465118934 27.539088211946662, 91.79931465118933 27.539088211946662, 91.79931465118933 27.50158821194666))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_0_2024-01-15 00:00:00.000000', 'assam_border/2_0', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=1', 'sentinel-2',
            -0.000000, 3.285634, 0.000000, 0.000000, 0.000000,
            0.8874, 1.3961, 0.5930, '{"quality": 0.887, "registration": 0.0, "seasonal": 0.783, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.86078473077187 27.500287097916974, 91.89078473077187 27.500287097916974, 91.89078473077187 27.537787097916976, 91.86078473077187 27.537787097916976, 91.86078473077187 27.500287097916974))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_0_2024-01-15 00:00:00.000000', 'assam_border/3_0', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 2.503866, 0.003072, 0.001528, -0.003072,
            0.8468, 0.7823, 0.5720, '{"quality": 0.847, "registration": 0.218, "seasonal": 0.623, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.88976608651944 27.500924687122122, 91.91976608651945 27.500924687122122, 91.91976608651945 27.538424687122124, 91.88976608651944 27.538424687122124, 91.88976608651944 27.500924687122122))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_0_2024-01-15 00:00:00.000000', 'assam_border/4_0', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 2.582064, 0.013465, -0.009817, -0.013465,
            0.8363, 0.2856, 0.6500, '{"quality": 0.836, "registration": 0.714, "seasonal": 0.642, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91944141283551 27.50062100138574, 91.94944141283551 27.50062100138574, 91.94944141283551 27.53812100138574, 91.91944141283551 27.53812100138574, 91.91944141283551 27.50062100138574))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_1_2024-01-15 00:00:00.000000', 'assam_border/1_1', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, 0.000402, 0.002126, -0.000402,
            0.9106, 0.8583, 0.4190, '{"quality": 0.911, "registration": 0.142, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.83011900062614 27.537548772698745, 91.86011900062614 27.537548772698745, 91.86011900062614 27.575048772698743, 91.83011900062614 27.575048772698743, 91.83011900062614 27.537548772698745))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_1_2024-01-15 00:00:00.000000', 'assam_border/3_1', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 3.805589, -0.001560, 0.003989, 0.001560,
            0.9850, 0.5797, 0.6930, '{"quality": 0.985, "registration": 0.42, "seasonal": 0.859, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.88910339471018 27.53646551123148, 91.91910339471018 27.53646551123148, 91.91910339471018 27.573965511231478, 91.88910339471018 27.573965511231478, 91.88910339471018 27.53646551123148))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_1_2024-01-15 00:00:00.000000', 'assam_border/4_1', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            -0.000000, 0.000000, 0.001013, -0.000945, -0.001013,
            0.9412, 0.3205, 0.5040, '{"quality": 0.941, "registration": 0.68, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91945809028091 27.536727991080205, 91.94945809028091 27.536727991080205, 91.94945809028091 27.574227991080207, 91.91945809028091 27.574227991080207, 91.91945809028091 27.536727991080205))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_2_2024-01-15 00:00:00.000000', 'assam_border/0_2', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 2.173714, -0.001068, -0.003883, 0.001068,
            0.8171, 1.2981, 0.5110, '{"quality": 0.817, "registration": 0.0, "seasonal": 0.543, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.7998453326341 27.573685043351592, 91.82984533263411 27.573685043351592, 91.82984533263411 27.61118504335159, 91.7998453326341 27.61118504335159, 91.7998453326341 27.573685043351592))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_2_2024-01-15 00:00:00.000000', 'assam_border/1_2', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 5.380911, 0.000996, -0.002837, -0.000996,
            0.9005, 1.2397, 0.6500, '{"quality": 0.901, "registration": 0.0, "seasonal": 0.967, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.83117070813752 27.57567780747397, 91.86117070813752 27.57567780747397, 91.86117070813752 27.613177807473967, 91.83117070813752 27.613177807473967, 91.83117070813752 27.57567780747397))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_2_2024-01-15 00:00:00.000000', 'assam_border/2_2', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, 0.015338, -0.006446, -0.015338,
            0.8618, 1.3007, 0.3900, '{"quality": 0.862, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85973681774668 27.574616895385365, 91.88973681774668 27.574616895385365, 91.88973681774668 27.612116895385363, 91.85973681774668 27.612116895385363, 91.85973681774668 27.574616895385365))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_2_2024-01-15 00:00:00.000000', 'assam_border/3_2', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            -0.000000, 0.000000, 0.003478, -0.005819, -0.003478,
            0.8759, 0.5899, 0.4540, '{"quality": 0.876, "registration": 0.41, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.89028020271287 27.57633891716022, 91.92028020271287 27.57633891716022, 91.92028020271287 27.613838917160223, 91.89028020271287 27.613838917160223, 91.89028020271287 27.57633891716022))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_2_2024-01-15 00:00:00.000000', 'assam_border/4_2', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.199303, 0.006757, -0.001485, -0.006757,
            0.8891, 0.6252, 0.5080, '{"quality": 0.889, "registration": 0.375, "seasonal": 0.31, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.9213493045582 27.57335444190286, 91.9513493045582 27.57335444190286, 91.9513493045582 27.61085444190286, 91.9213493045582 27.61085444190286, 91.9213493045582 27.57335444190286))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_3_2024-01-15 00:00:00.000000', 'assam_border/2_3', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.001277, -0.000617, 0.001277,
            0.9414, 0.9759, 0.4060, '{"quality": 0.941, "registration": 0.024, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.86010003726868 27.611940604138105, 91.89010003726868 27.611940604138105, 91.89010003726868 27.649440604138107, 91.86010003726868 27.649440604138107, 91.86010003726868 27.611940604138105))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_3_2024-01-15 00:00:00.000000', 'assam_border/3_3', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, 0.002120, -0.003265, -0.002120,
            0.9660, 1.1484, 0.4060, '{"quality": 0.966, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8887676042436 27.61429466324138, 91.9187676042436 27.61429466324138, 91.9187676042436 27.651794663241382, 91.8887676042436 27.651794663241382, 91.8887676042436 27.61429466324138))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_3_2024-01-15 00:00:00.000000', 'assam_border/4_3', 'assam_border', '2024-01-15 00:00:00', 'post-monsoon_N=2', 'sentinel-2',
            0.000000, 1.137126, -0.007159, 0.001472, 0.007159,
            0.8188, 1.0071, 0.4370, '{"quality": 0.819, "registration": 0.0, "seasonal": 0.297, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91938696196215 27.612897621224196, 91.94938696196215 27.612897621224196, 91.94938696196215 27.650397621224194, 91.91938696196215 27.650397621224194, 91.91938696196215 27.612897621224196))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_0_2024-06-15 00:00:00.000000', 'assam_border/0_0', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, 0.007719, -0.000567, -0.007719,
            0.8315, 1.4672, 0.3850, '{"quality": 0.831, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.800169560509 27.501804158195014, 91.830169560509 27.501804158195014, 91.830169560509 27.539304158195016, 91.800169560509 27.539304158195016, 91.800169560509 27.501804158195014))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_0_2024-06-15 00:00:00.000000', 'assam_border/1_0', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.947185, 0.001421, -0.004098, -0.001421,
            0.8615, 0.0131, 0.6480, '{"quality": 0.861, "registration": 0.987, "seasonal": 0.487, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8290821666018 27.50143627740403, 91.8590821666018 27.50143627740403, 91.8590821666018 27.538936277404026, 91.8290821666018 27.538936277404026, 91.8290821666018 27.50143627740403))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_0_2024-06-15 00:00:00.000000', 'assam_border/2_0', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            -0.000000, 0.000000, -0.010854, 0.007298, 0.010854,
            0.9048, 0.3917, 0.4880, '{"quality": 0.905, "registration": 0.608, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85928305217067 27.50079472058985, 91.88928305217067 27.50079472058985, 91.88928305217067 27.538294720589853, 91.85928305217067 27.538294720589853, 91.85928305217067 27.50079472058985))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_0_2024-06-15 00:00:00.000000', 'assam_border/3_0', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=1', 'sentinel-2',
            0.000000, 4.099869, 0.000000, 0.000000, 0.000000,
            0.8299, 0.7380, 0.6560, '{"quality": 0.83, "registration": 0.262, "seasonal": 0.891, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.88969320977219 27.50004011744394, 91.91969320977219 27.50004011744394, 91.91969320977219 27.53754011744394, 91.88969320977219 27.53754011744394, 91.88969320977219 27.50004011744394))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_0_2024-06-15 00:00:00.000000', 'assam_border/4_0', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.004766, 0.001836, 0.004766,
            0.9301, 0.0217, 0.5470, '{"quality": 0.93, "registration": 0.978, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92081679876433 27.498569160185298, 91.95081679876434 27.498569160185298, 91.95081679876434 27.5360691601853, 91.92081679876433 27.5360691601853, 91.92081679876433 27.498569160185298))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_1_2024-06-15 00:00:00.000000', 'assam_border/1_1', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.355877, -0.001682, 0.003933, 0.001682,
            0.8233, 0.3560, 0.4940, '{"quality": 0.823, "registration": 0.644, "seasonal": 0.162, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82919999239466 27.537935025954678, 91.85919999239466 27.537935025954678, 91.85919999239466 27.575435025954675, 91.82919999239466 27.575435025954675, 91.82919999239466 27.537935025954678))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_1_2024-06-15 00:00:00.000000', 'assam_border/2_1', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 2.627034, 0.000593, -0.006983, -0.000593,
            0.9364, 0.5857, 0.6230, '{"quality": 0.936, "registration": 0.414, "seasonal": 0.652, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8589764607235 27.537896743762516, 91.8889764607235 27.537896743762516, 91.8889764607235 27.575396743762518, 91.8589764607235 27.575396743762518, 91.8589764607235 27.537896743762516))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_1_2024-06-15 00:00:00.000000', 'assam_border/3_1', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.003401, -0.006761, 0.003401,
            0.8060, 0.7052, 0.4260, '{"quality": 0.806, "registration": 0.295, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.8911649559378 27.539277309898434, 91.9211649559378 27.539277309898434, 91.9211649559378 27.576777309898432, 91.8911649559378 27.576777309898432, 91.8911649559378 27.539277309898434))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_1_2024-06-15 00:00:00.000000', 'assam_border/4_1', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            -0.000000, 1.454801, -0.008052, -0.005105, 0.008052,
            0.8235, 0.2640, 0.5690, '{"quality": 0.823, "registration": 0.736, "seasonal": 0.367, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.92061624258183 27.53595609296165, 91.95061624258183 27.53595609296165, 91.95061624258183 27.57345609296165, 91.92061624258183 27.57345609296165, 91.92061624258183 27.53595609296165))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_2_2024-06-15 00:00:00.000000', 'assam_border/0_2', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 3.614286, -0.001036, 0.008231, 0.001036,
            0.9119, 0.8222, 0.6390, '{"quality": 0.912, "registration": 0.178, "seasonal": 0.834, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79878996904682 27.57499812991114, 91.82878996904682 27.57499812991114, 91.82878996904682 27.61249812991114, 91.79878996904682 27.61249812991114, 91.79878996904682 27.57499812991114))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_2_2024-06-15 00:00:00.000000', 'assam_border/1_2', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.004364, -0.003686, 0.004364,
            0.8890, 0.9599, 0.4000, '{"quality": 0.889, "registration": 0.04, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82865149702168 27.57565763514617, 91.85865149702168 27.57565763514617, 91.85865149702168 27.613157635146173, 91.82865149702168 27.613157635146173, 91.82865149702168 27.57565763514617))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_2_2024-06-15 00:00:00.000000', 'assam_border/2_2', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.369268, 0.006179, 0.000096, -0.006179,
            0.9832, 0.0653, 0.6170, '{"quality": 0.983, "registration": 0.935, "seasonal": 0.347, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.85910179228881 27.573142691881152, 91.88910179228881 27.573142691881152, 91.88910179228881 27.610642691881154, 91.85910179228881 27.610642691881154, 91.85910179228881 27.573142691881152))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/3_2_2024-06-15 00:00:00.000000', 'assam_border/3_2', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=1', 'sentinel-2',
            -0.000000, 1.519754, 0.000000, 0.000000, 0.000000,
            0.8050, 0.2544, 0.5720, '{"quality": 0.805, "registration": 0.746, "seasonal": 0.382, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.88864382714456 27.575621999709956, 91.91864382714456 27.575621999709956, 91.91864382714456 27.613121999709954, 91.88864382714456 27.613121999709954, 91.88864382714456 27.575621999709956))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_2_2024-06-15 00:00:00.000000', 'assam_border/4_2', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 2.563646, 0.000704, -0.013424, -0.000704,
            0.8039, 0.1279, 0.6680, '{"quality": 0.804, "registration": 0.872, "seasonal": 0.637, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91952611249287 27.574647048031572, 91.94952611249288 27.574647048031572, 91.94952611249288 27.612147048031574, 91.91952611249287 27.612147048031574, 91.91952611249287 27.574647048031572))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/0_3_2024-06-15 00:00:00.000000', 'assam_border/0_3', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, -0.006614, -0.002877, 0.006614,
            0.8791, 0.0720, 0.5320, '{"quality": 0.879, "registration": 0.928, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.79939299811164 27.611634799576176, 91.82939299811164 27.611634799576176, 91.82939299811164 27.649134799576174, 91.79939299811164 27.649134799576174, 91.79939299811164 27.611634799576176))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/1_3_2024-06-15 00:00:00.000000', 'assam_border/1_3', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 0.000000, 0.002839, -0.002018, -0.002839,
            0.8877, 1.2687, 0.3940, '{"quality": 0.888, "registration": 0.0, "seasonal": 0.119, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.82862571763422 27.611595522688113, 91.85862571763423 27.611595522688113, 91.85862571763423 27.649095522688114, 91.82862571763422 27.649095522688114, 91.82862571763422 27.611595522688113))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/2_3_2024-06-15 00:00:00.000000', 'assam_border/2_3', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 2.043883, -0.010605, 0.009392, 0.010605,
            0.9752, 1.0512, 0.5250, '{"quality": 0.975, "registration": 0.0, "seasonal": 0.511, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.86066995750248 27.61185636682925, 91.89066995750248 27.61185636682925, 91.89066995750248 27.649356366829252, 91.86066995750248 27.649356366829252, 91.86066995750248 27.61185636682925))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;
INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            'assam_border/4_3_2024-06-15 00:00:00.000000', 'assam_border/4_3', 'assam_border', '2024-06-15 00:00:00', 'monsoon_N=2', 'sentinel-2',
            0.000000, 1.593969, -0.007567, 0.006287, 0.007567,
            0.9093, 0.8511, 0.5040, '{"quality": 0.909, "registration": 0.149, "seasonal": 0.4, "radiometric": 1.0, "persistence": 0.5, "persistence_status": "unknown_insufficient_obs", "sar": "unavailable"}'::jsonb,
            ST_GeomFromText('POLYGON((91.91907736847263 27.611103685015095, 91.94907736847263 27.611103685015095, 91.94907736847263 27.648603685015097, 91.91907736847263 27.648603685015097, 91.91907736847263 27.611103685015095))', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;

COMMIT;