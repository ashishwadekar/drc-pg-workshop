SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: full_address; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE full_address AS (
	city character varying(90),
	street character varying(90)
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: branch_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE branch_permissions (
    id bigint NOT NULL,
    system_user_id integer NOT NULL,
    restaurant_branch_id integer NOT NULL
);


--
-- Name: branch_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE branch_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: branch_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE branch_permissions_id_seq OWNED BY branch_permissions.id;


--
-- Name: menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE menu_items (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    price numeric(10,2)
);


--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE menu_items_id_seq OWNED BY menu_items.id;


--
-- Name: restaurant_branch_menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurant_branch_menu_items (
    id bigint NOT NULL,
    restaurant_branch_id integer,
    menu_item_id integer
);


--
-- Name: restaurant_branch_menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurant_branch_menu_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurant_branch_menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurant_branch_menu_items_id_seq OWNED BY restaurant_branch_menu_items.id;


--
-- Name: restaurant_branches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurant_branches (
    id bigint NOT NULL,
    restaurant_id bigint,
    name character varying,
    address full_address
);


--
-- Name: restaurant_branches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurant_branches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurant_branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurant_branches_id_seq OWNED BY restaurant_branches.id;


--
-- Name: restaurant_menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurant_menu_items (
    id bigint NOT NULL,
    restaurant_id integer,
    menu_item_id integer
);


--
-- Name: restaurant_menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurant_menu_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurant_menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurant_menu_items_id_seq OWNED BY restaurant_menu_items.id;


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurants (
    id bigint NOT NULL,
    name character varying,
    description character varying
);


--
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurants_id_seq OWNED BY restaurants.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: system_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE system_users (
    id bigint NOT NULL,
    restaurant_id bigint,
    username character varying,
    password character varying
);


--
-- Name: system_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE system_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE system_users_id_seq OWNED BY system_users.id;


--
-- Name: wizards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE wizards (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wizards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wizards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wizards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wizards_id_seq OWNED BY wizards.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY branch_permissions ALTER COLUMN id SET DEFAULT nextval('branch_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu_items ALTER COLUMN id SET DEFAULT nextval('menu_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branch_menu_items ALTER COLUMN id SET DEFAULT nextval('restaurant_branch_menu_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branches ALTER COLUMN id SET DEFAULT nextval('restaurant_branches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_menu_items ALTER COLUMN id SET DEFAULT nextval('restaurant_menu_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurants ALTER COLUMN id SET DEFAULT nextval('restaurants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_users ALTER COLUMN id SET DEFAULT nextval('system_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wizards ALTER COLUMN id SET DEFAULT nextval('wizards_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: branch_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY branch_permissions
    ADD CONSTRAINT branch_permissions_pkey PRIMARY KEY (id);


--
-- Name: menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- Name: restaurant_branch_menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branch_menu_items
    ADD CONSTRAINT restaurant_branch_menu_items_pkey PRIMARY KEY (id);


--
-- Name: restaurant_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branches
    ADD CONSTRAINT restaurant_branches_pkey PRIMARY KEY (id);


--
-- Name: restaurant_menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_menu_items
    ADD CONSTRAINT restaurant_menu_items_pkey PRIMARY KEY (id);


--
-- Name: restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: system_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_users
    ADD CONSTRAINT system_users_pkey PRIMARY KEY (id);


--
-- Name: wizards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wizards
    ADD CONSTRAINT wizards_pkey PRIMARY KEY (id);


--
-- Name: index_restaurant_branches_on_restaurant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_restaurant_branches_on_restaurant_id ON restaurant_branches USING btree (restaurant_id);


--
-- Name: index_system_users_on_restaurant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_system_users_on_restaurant_id ON system_users USING btree (restaurant_id);


--
-- Name: restaurant_name_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX restaurant_name_uniqueness ON restaurants USING btree (lower((name)::text));


--
-- Name: fk_rails_0680420eea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branch_menu_items
    ADD CONSTRAINT fk_rails_0680420eea FOREIGN KEY (restaurant_branch_id) REFERENCES restaurant_branches(id) ON DELETE CASCADE;


--
-- Name: fk_rails_25ab1442b5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branch_menu_items
    ADD CONSTRAINT fk_rails_25ab1442b5 FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE;


--
-- Name: fk_rails_3886056ff9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_menu_items
    ADD CONSTRAINT fk_rails_3886056ff9 FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE;


--
-- Name: fk_rails_51ae0f8915; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY branch_permissions
    ADD CONSTRAINT fk_rails_51ae0f8915 FOREIGN KEY (system_user_id) REFERENCES system_users(id) ON DELETE CASCADE;


--
-- Name: fk_rails_561eacd5c6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_branches
    ADD CONSTRAINT fk_rails_561eacd5c6 FOREIGN KEY (restaurant_id) REFERENCES restaurants(id);


--
-- Name: fk_rails_6e24155834; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant_menu_items
    ADD CONSTRAINT fk_rails_6e24155834 FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE;


--
-- Name: fk_rails_a9d7eeb9e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_users
    ADD CONSTRAINT fk_rails_a9d7eeb9e2 FOREIGN KEY (restaurant_id) REFERENCES restaurants(id);


--
-- Name: fk_rails_faba1d89ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY branch_permissions
    ADD CONSTRAINT fk_rails_faba1d89ac FOREIGN KEY (restaurant_branch_id) REFERENCES restaurant_branches(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170809075920'),
('20170810100253'),
('20170810100758'),
('20170810101602'),
('20170810102648'),
('20170810111959'),
('20170810112514'),
('20170810114149'),
('20170810131251');


