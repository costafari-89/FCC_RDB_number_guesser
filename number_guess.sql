--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: user_info; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.user_info (
    username character varying(22),
    games_played integer,
    best_game_guess integer
);


ALTER TABLE public.user_info OWNER TO freecodecamp;

--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.user_info VALUES ('markcosta', 3, 19);
INSERT INTO public.user_info VALUES ('user_1714168554169', 2, 23);
INSERT INTO public.user_info VALUES ('user_1714168554170', 5, 50);
INSERT INTO public.user_info VALUES ('costa', 1, 21);
INSERT INTO public.user_info VALUES ('user_1714169099808', 2, 688);
INSERT INTO public.user_info VALUES ('user_1714169099809', 5, 131);
INSERT INTO public.user_info VALUES ('user_1714169276383', 2, 797);
INSERT INTO public.user_info VALUES ('user_1714169276384', 5, 12);
INSERT INTO public.user_info VALUES ('user_1714169630247', 2, 81);
INSERT INTO public.user_info VALUES ('user_1714169630248', 5, 57);
INSERT INTO public.user_info VALUES ('user_1714169734157', 2, 149);
INSERT INTO public.user_info VALUES ('user_1714169734158', 5, 333);


--
-- Name: user_info user_info_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

