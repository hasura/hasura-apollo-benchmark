CREATE TABLE public.album (
    albumid bigint NOT NULL,
    title text,
    artistid bigint
);
CREATE SEQUENCE public.album_albumid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.album_albumid_seq OWNED BY public.album.albumid;
CREATE TABLE public.artist (
    artistid bigint NOT NULL,
    name text
);
CREATE SEQUENCE public.artist_artistid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.artist_artistid_seq OWNED BY public.artist.artistid;
CREATE TABLE public.customer (
    customerid bigint NOT NULL,
    firstname text,
    lastname text,
    company text,
    address text,
    city text,
    state text,
    country text,
    postalcode text,
    phone text,
    fax text,
    email text,
    supportrepid bigint
);
CREATE SEQUENCE public.customer_customerid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.customer_customerid_seq OWNED BY public.customer.customerid;
CREATE TABLE public.employee (
    employeeid bigint NOT NULL,
    lastname text,
    firstname text,
    title text,
    reportsto bigint,
    birthdate timestamp with time zone,
    hiredate timestamp with time zone,
    address text,
    city text,
    state text,
    country text,
    postalcode text,
    phone text,
    fax text,
    email text
);
CREATE SEQUENCE public.employee_employeeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.employee_employeeid_seq OWNED BY public.employee.employeeid;
CREATE TABLE public.genre (
    genreid bigint NOT NULL,
    name text
);
CREATE SEQUENCE public.genre_genreid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.genre_genreid_seq OWNED BY public.genre.genreid;
CREATE TABLE public.invoice (
    invoiceid bigint NOT NULL,
    customerid bigint,
    invoicedate timestamp with time zone,
    billingaddress text,
    billingcity text,
    billingstate text,
    billingcountry text,
    billingpostalcode text,
    total numeric(10,2)
);
CREATE SEQUENCE public.invoice_invoiceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.invoice_invoiceid_seq OWNED BY public.invoice.invoiceid;
CREATE TABLE public.invoiceline (
    invoicelineid bigint NOT NULL,
    invoiceid bigint,
    trackid bigint,
    unitprice numeric(10,2),
    quantity bigint
);
CREATE SEQUENCE public.invoiceline_invoicelineid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.invoiceline_invoicelineid_seq OWNED BY public.invoiceline.invoicelineid;
CREATE TABLE public.mediatype (
    mediatypeid bigint NOT NULL,
    name text
);
CREATE SEQUENCE public.mediatype_mediatypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.mediatype_mediatypeid_seq OWNED BY public.mediatype.mediatypeid;
CREATE TABLE public.playlist (
    playlistid bigint NOT NULL,
    name text
);
CREATE SEQUENCE public.playlist_playlistid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.playlist_playlistid_seq OWNED BY public.playlist.playlistid;
CREATE TABLE public.playlisttrack (
    playlistid bigint NOT NULL,
    trackid bigint NOT NULL
);
CREATE TABLE public.track (
    trackid bigint NOT NULL,
    name text,
    albumid bigint,
    mediatypeid bigint,
    genreid bigint,
    composer text,
    milliseconds bigint,
    bytes bigint,
    unitprice numeric(10,2)
);
CREATE SEQUENCE public.track_trackid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.track_trackid_seq OWNED BY public.track.trackid;
ALTER TABLE ONLY public.album ALTER COLUMN albumid SET DEFAULT nextval('public.album_albumid_seq'::regclass);
ALTER TABLE ONLY public.artist ALTER COLUMN artistid SET DEFAULT nextval('public.artist_artistid_seq'::regclass);
ALTER TABLE ONLY public.customer ALTER COLUMN customerid SET DEFAULT nextval('public.customer_customerid_seq'::regclass);
ALTER TABLE ONLY public.employee ALTER COLUMN employeeid SET DEFAULT nextval('public.employee_employeeid_seq'::regclass);
ALTER TABLE ONLY public.genre ALTER COLUMN genreid SET DEFAULT nextval('public.genre_genreid_seq'::regclass);
ALTER TABLE ONLY public.invoice ALTER COLUMN invoiceid SET DEFAULT nextval('public.invoice_invoiceid_seq'::regclass);
ALTER TABLE ONLY public.invoiceline ALTER COLUMN invoicelineid SET DEFAULT nextval('public.invoiceline_invoicelineid_seq'::regclass);
ALTER TABLE ONLY public.mediatype ALTER COLUMN mediatypeid SET DEFAULT nextval('public.mediatype_mediatypeid_seq'::regclass);
ALTER TABLE ONLY public.playlist ALTER COLUMN playlistid SET DEFAULT nextval('public.playlist_playlistid_seq'::regclass);
ALTER TABLE ONLY public.track ALTER COLUMN trackid SET DEFAULT nextval('public.track_trackid_seq'::regclass);
ALTER TABLE ONLY public.album
    ADD CONSTRAINT idx_16697_album_pkey PRIMARY KEY (albumid);
ALTER TABLE ONLY public.artist
    ADD CONSTRAINT idx_16706_artist_pkey PRIMARY KEY (artistid);
ALTER TABLE ONLY public.customer
    ADD CONSTRAINT idx_16715_customer_pkey PRIMARY KEY (customerid);
ALTER TABLE ONLY public.employee
    ADD CONSTRAINT idx_16724_employee_pkey PRIMARY KEY (employeeid);
ALTER TABLE ONLY public.genre
    ADD CONSTRAINT idx_16733_genre_pkey PRIMARY KEY (genreid);
ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT idx_16742_invoice_pkey PRIMARY KEY (invoiceid);
ALTER TABLE ONLY public.invoiceline
    ADD CONSTRAINT idx_16751_invoiceline_pkey PRIMARY KEY (invoicelineid);
ALTER TABLE ONLY public.mediatype
    ADD CONSTRAINT idx_16757_mediatype_pkey PRIMARY KEY (mediatypeid);
ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT idx_16766_playlist_pkey PRIMARY KEY (playlistid);
ALTER TABLE ONLY public.playlisttrack
    ADD CONSTRAINT idx_16773_playlisttrack_pkey PRIMARY KEY (playlistid, trackid);
ALTER TABLE ONLY public.track
    ADD CONSTRAINT idx_16778_track_pkey PRIMARY KEY (trackid);
CREATE INDEX idx_16697_ifk_albumartistid ON public.album USING btree (artistid);
CREATE UNIQUE INDEX idx_16697_ipk_album ON public.album USING btree (albumid);
CREATE UNIQUE INDEX idx_16706_ipk_artist ON public.artist USING btree (artistid);
CREATE INDEX idx_16715_ifk_customersupportrepid ON public.customer USING btree (supportrepid);
CREATE UNIQUE INDEX idx_16715_ipk_customer ON public.customer USING btree (customerid);
CREATE INDEX idx_16724_ifk_employeereportsto ON public.employee USING btree (reportsto);
CREATE UNIQUE INDEX idx_16724_ipk_employee ON public.employee USING btree (employeeid);
CREATE UNIQUE INDEX idx_16733_ipk_genre ON public.genre USING btree (genreid);
CREATE INDEX idx_16742_ifk_invoicecustomerid ON public.invoice USING btree (customerid);
CREATE UNIQUE INDEX idx_16742_ipk_invoice ON public.invoice USING btree (invoiceid);
CREATE INDEX idx_16751_ifk_invoicelineinvoiceid ON public.invoiceline USING btree (invoiceid);
CREATE INDEX idx_16751_ifk_invoicelinetrackid ON public.invoiceline USING btree (trackid);
CREATE UNIQUE INDEX idx_16751_ipk_invoiceline ON public.invoiceline USING btree (invoicelineid);
CREATE UNIQUE INDEX idx_16757_ipk_mediatype ON public.mediatype USING btree (mediatypeid);
CREATE UNIQUE INDEX idx_16766_ipk_playlist ON public.playlist USING btree (playlistid);
CREATE INDEX idx_16773_ifk_playlisttracktrackid ON public.playlisttrack USING btree (trackid);
CREATE UNIQUE INDEX idx_16773_ipk_playlisttrack ON public.playlisttrack USING btree (playlistid, trackid);
CREATE UNIQUE INDEX idx_16773_sqlite_autoindex_playlisttrack_1 ON public.playlisttrack USING btree (playlistid, trackid);
CREATE INDEX idx_16778_ifk_trackalbumid ON public.track USING btree (albumid);
CREATE INDEX idx_16778_ifk_trackgenreid ON public.track USING btree (genreid);
CREATE INDEX idx_16778_ifk_trackmediatypeid ON public.track USING btree (mediatypeid);
CREATE UNIQUE INDEX idx_16778_ipk_track ON public.track USING btree (trackid);
ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_artistid_fkey FOREIGN KEY (artistid) REFERENCES public.artist(artistid);
ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_supportrepid_fkey FOREIGN KEY (supportrepid) REFERENCES public.employee(employeeid);
ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_reportsto_fkey FOREIGN KEY (reportsto) REFERENCES public.employee(employeeid);
ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customer(customerid);
ALTER TABLE ONLY public.invoiceline
    ADD CONSTRAINT invoiceline_invoiceid_fkey FOREIGN KEY (invoiceid) REFERENCES public.invoice(invoiceid);
ALTER TABLE ONLY public.invoiceline
    ADD CONSTRAINT invoiceline_trackid_fkey FOREIGN KEY (trackid) REFERENCES public.track(trackid);
ALTER TABLE ONLY public.playlisttrack
    ADD CONSTRAINT playlisttrack_playlistid_fkey FOREIGN KEY (playlistid) REFERENCES public.playlist(playlistid);
ALTER TABLE ONLY public.playlisttrack
    ADD CONSTRAINT playlisttrack_trackid_fkey FOREIGN KEY (trackid) REFERENCES public.track(trackid);
ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_albumid_fkey FOREIGN KEY (albumid) REFERENCES public.album(albumid);
ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_genreid_fkey FOREIGN KEY (genreid) REFERENCES public.genre(genreid);
ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_mediatypeid_fkey FOREIGN KEY (mediatypeid) REFERENCES public.mediatype(mediatypeid);
