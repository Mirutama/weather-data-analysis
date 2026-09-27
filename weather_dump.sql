--
-- PostgreSQL database dump
--

\restrict bHlyJoczOfgV9Yut2Wxl85iN7lkiwc0l6Dhhg1zWPeC1ECHtAtjVah0Dv77SzGI

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: weather; Type: TABLE; Schema: public; Owner: weather_user
--

CREATE TABLE public.weather (
    "年月日" date,
    "最高気温(℃)" double precision,
    "最低気温(℃)" double precision,
    "平均気温(℃)" double precision,
    "降水量の合計(mm)" double precision
);


ALTER TABLE public.weather OWNER TO weather_user;

--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: weather_user
--

INSERT INTO public.weather VALUES ('2025-12-01', 21.6, 7.9, 14.6, 0);
INSERT INTO public.weather VALUES ('2025-12-02', 18.3, 11.6, 14.4, 0);
INSERT INTO public.weather VALUES ('2025-12-03', 14.5, 8.9, 11.9, 0);
INSERT INTO public.weather VALUES ('2025-12-04', 11.4, 5.5, 7.9, 0);
INSERT INTO public.weather VALUES ('2025-12-05', 12.5, 3.7, 8.1, 0);
INSERT INTO public.weather VALUES ('2025-12-06', 11.5, 3.6, 7.7, 0);
INSERT INTO public.weather VALUES ('2025-12-07', 15.8, 4, 9.8, 0);
INSERT INTO public.weather VALUES ('2025-12-08', 18.6, 6.2, 12.4, 0);
INSERT INTO public.weather VALUES ('2025-12-09', 12.8, 7.9, 10.5, 0);
INSERT INTO public.weather VALUES ('2025-12-10', 13.3, 5.6, 9.4, 0);
INSERT INTO public.weather VALUES ('2025-12-11', 16.3, 6.2, 11.4, 0);
INSERT INTO public.weather VALUES ('2025-12-12', 14.2, 4.3, 7.8, 0);
INSERT INTO public.weather VALUES ('2025-12-13', 8.5, 4.4, 6, 3.5);
INSERT INTO public.weather VALUES ('2025-12-14', 9, 3.1, 5.8, 19.5);
INSERT INTO public.weather VALUES ('2025-12-15', 13.7, 5.9, 9.3, 0);
INSERT INTO public.weather VALUES ('2025-12-16', 12.4, 6.3, 8.9, 0);
INSERT INTO public.weather VALUES ('2025-12-17', 13.6, 5.4, 9.6, 0);
INSERT INTO public.weather VALUES ('2025-12-18', 13.4, 7.5, 10, 0);
INSERT INTO public.weather VALUES ('2025-12-19', 12.3, 4.8, 8.4, 0);
INSERT INTO public.weather VALUES ('2025-12-20', 13, 6.7, 9.5, 16.5);
INSERT INTO public.weather VALUES ('2025-12-21', 18.8, 8.9, 13.5, 2.5);
INSERT INTO public.weather VALUES ('2025-12-22', 12.8, 6, 10.2, 0);
INSERT INTO public.weather VALUES ('2025-12-23', 10.3, 3.2, 7.1, 0);
INSERT INTO public.weather VALUES ('2025-12-24', 9.1, 5.1, 7.2, 7);
INSERT INTO public.weather VALUES ('2025-12-25', 12.7, 8.6, 10.2, 3);
INSERT INTO public.weather VALUES ('2025-12-26', 11.5, 3, 7.8, 0);
INSERT INTO public.weather VALUES ('2025-12-27', 5.9, 2.5, 4.2, 0);
INSERT INTO public.weather VALUES ('2025-12-28', 12, 1.1, 6.4, 0);
INSERT INTO public.weather VALUES ('2025-12-29', 12.4, 4.3, 8.5, 0);
INSERT INTO public.weather VALUES ('2025-12-30', 15.1, 5, 9.9, 0);
INSERT INTO public.weather VALUES ('2025-12-31', 11.9, 5.1, 8.8, 0);
INSERT INTO public.weather VALUES ('2026-01-01', 9.9, 4.8, 7.4, 0);
INSERT INTO public.weather VALUES ('2026-01-02', 9.4, 1, 5.6, 6);
INSERT INTO public.weather VALUES ('2026-01-03', 9.4, 1.2, 5.1, 0);
INSERT INTO public.weather VALUES ('2026-01-04', 11.2, 1.7, 6.7, 0);
INSERT INTO public.weather VALUES ('2026-01-05', 13.9, 2.6, 8.1, 0);
INSERT INTO public.weather VALUES ('2026-01-06', 11.1, 4.1, 6.8, 0);
INSERT INTO public.weather VALUES ('2026-01-07', 7.1, 3, 4.6, 0);
INSERT INTO public.weather VALUES ('2026-01-08', 12.4, 1.4, 5.2, 0);
INSERT INTO public.weather VALUES ('2026-01-09', 10.3, 1.9, 6.2, 0);
INSERT INTO public.weather VALUES ('2026-01-10', 15.2, 2.8, 9.7, 0);
INSERT INTO public.weather VALUES ('2026-01-11', 15.2, 2.5, 10.7, 0);
INSERT INTO public.weather VALUES ('2026-01-12', 9.8, 1, 5, 0);
INSERT INTO public.weather VALUES ('2026-01-13', 15.4, 1.9, 9.6, 0);
INSERT INTO public.weather VALUES ('2026-01-14', 11.3, 5, 7.8, 0);
INSERT INTO public.weather VALUES ('2026-01-15', 12.6, 2.9, 8.1, 0);
INSERT INTO public.weather VALUES ('2026-01-16', 16.9, 9.2, 12.6, 0);
INSERT INTO public.weather VALUES ('2026-01-17', 13.8, 5.6, 10, 0);
INSERT INTO public.weather VALUES ('2026-01-18', 13.2, 6.4, 9.5, 0);
INSERT INTO public.weather VALUES ('2026-01-19', 13.8, 5.9, 9.7, 0);
INSERT INTO public.weather VALUES ('2026-01-20', 9, 2.6, 6.6, 0);
INSERT INTO public.weather VALUES ('2026-01-21', 6.5, 2.4, 3.7, 0);
INSERT INTO public.weather VALUES ('2026-01-22', 7.3, 0.6, 3.3, 0);
INSERT INTO public.weather VALUES ('2026-01-23', 9.1, 0, 4.4, 0);
INSERT INTO public.weather VALUES ('2026-01-24', 10.6, 0.2, 5.3, 0);
INSERT INTO public.weather VALUES ('2026-01-25', 7.7, 1.6, 4.2, 0);
INSERT INTO public.weather VALUES ('2026-01-26', 9, 1.7, 4.8, 0);
INSERT INTO public.weather VALUES ('2026-01-27', 9.2, 2.8, 5.8, 0);
INSERT INTO public.weather VALUES ('2026-01-28', 7.8, 4, 6, 0);
INSERT INTO public.weather VALUES ('2026-01-29', 9.4, 2.3, 5.2, 0);
INSERT INTO public.weather VALUES ('2026-01-30', 8.7, 0.2, 4.1, 0);
INSERT INTO public.weather VALUES ('2026-01-31', 9.3, 1.2, 4.9, 0);


--
-- PostgreSQL database dump complete
--

\unrestrict bHlyJoczOfgV9Yut2Wxl85iN7lkiwc0l6Dhhg1zWPeC1ECHtAtjVah0Dv77SzGI

