toc.dat                                                                                             0000600 0004000 0002000 00000031224 14501220317 0014434 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                           {            proyecto_da_db    15.3    15.3 (    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         O           1262    17153    proyecto_da_db    DATABASE     �   CREATE DATABASE proyecto_da_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_El Salvador.1252';
    DROP DATABASE proyecto_da_db;
                postgres    false         �            1259    17288 	   campaigns    TABLE     �   CREATE TABLE public.campaigns (
    campaign_id integer NOT NULL,
    campaign_type character varying(255),
    campaign_mediatype character varying(255),
    startdate date,
    finishdate date
);
    DROP TABLE public.campaigns;
       public         heap    postgres    false         �            1259    17293    category    TABLE     �   CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(255),
    category_description text
);
    DROP TABLE public.category;
       public         heap    postgres    false         �            1259    17316    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    supplier_id integer,
    category_id integer,
    product_name character varying(255),
    product_price numeric
);
    DROP TABLE public.products;
       public         heap    postgres    false         �            1259    17334 	   suppliers    TABLE       CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255),
    supplier_adress character varying(255),
    supplier_country character varying(255),
    supplier_email character varying(255),
    supplier_phone character varying(255)
);
    DROP TABLE public.suppliers;
       public         heap    postgres    false         �            1259    17594    costo_productos_proveedores    VIEW       CREATE VIEW public.costo_productos_proveedores AS
 SELECT p.product_name,
    sp.supplier_name,
    p.product_price
   FROM (public.products p
     JOIN public.suppliers sp ON ((p.supplier_id = sp.supplier_id)))
  GROUP BY p.product_name, sp.supplier_name, p.product_price;
 .   DROP VIEW public.costo_productos_proveedores;
       public          postgres    false    220    224    224    220    220         �            1259    17298 	   customers    TABLE     N  CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    customer_name character varying(255),
    customer_adress text,
    customer_age integer,
    customer_city character varying(255),
    customer_phone character varying(255),
    customer_email character varying(255),
    customer_gender character varying(255)
);
    DROP TABLE public.customers;
       public         heap    postgres    false         �            1259    17303 	   employees    TABLE     �   CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    store_id integer,
    employee_name character varying(255),
    employee_gender character varying(255),
    employee_birthdate date,
    employee_phone character varying(255)
);
    DROP TABLE public.employees;
       public         heap    postgres    false         �            1259    17308 
   fact_sales    TABLE     �   CREATE TABLE public.fact_sales (
    sales_id integer NOT NULL,
    customer_id integer,
    employee_id integer,
    shipment_id integer,
    campaign_id integer,
    salesdate date,
    totalsales numeric
);
    DROP TABLE public.fact_sales;
       public         heap    postgres    false         �            1259    17589    impactocampana_venta    VIEW     �  CREATE VIEW public.impactocampana_venta AS
 SELECT s.campaign_id,
    sum(s.totalsales) AS total,
    cam.startdate AS fecha_inico_campana,
    cam.finishdate AS fecha_final_campana
   FROM (public.fact_sales s
     JOIN public.campaigns cam ON ((s.campaign_id = cam.campaign_id)))
  WHERE ((s.salesdate >= '2022-01-01'::date) AND (s.salesdate <= '2023-09-11'::date))
  GROUP BY s.campaign_id, cam.startdate, cam.finishdate
  ORDER BY (sum(s.totalsales)) DESC;
 '   DROP VIEW public.impactocampana_venta;
       public          postgres    false    218    218    218    214    214    214         �            1259    17313 	   inventory    TABLE     �   CREATE TABLE public.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    product_sold integer,
    product_quantity integer,
    product_available integer
);
    DROP TABLE public.inventory;
       public         heap    postgres    false         �            1259    17321    salesdetails    TABLE     �   CREATE TABLE public.salesdetails (
    salesdetails_id integer NOT NULL,
    sales_id integer,
    product_id integer,
    store_id integer,
    product_quantity integer
);
     DROP TABLE public.salesdetails;
       public         heap    postgres    false         �            1259    17324    shipment    TABLE     �   CREATE TABLE public.shipment (
    shipment_id integer NOT NULL,
    shipper_name character varying(255),
    shipper_phone character varying(255)
);
    DROP TABLE public.shipment;
       public         heap    postgres    false         �            1259    17329    stores    TABLE     �   CREATE TABLE public.stores (
    store_id integer NOT NULL,
    store_adress character varying(255),
    store_type character varying(255)
);
    DROP TABLE public.stores;
       public         heap    postgres    false         �            1259    17584    top10productosmasvendidos    VIEW     �  CREATE VIEW public.top10productosmasvendidos AS
 SELECT cu.customer_name,
    sl.customer_id,
    cu.customer_age,
    cu.customer_gender,
    cu.customer_city,
    sum(sl.totalsales) AS ventatotal
   FROM (public.fact_sales sl
     JOIN public.customers cu ON ((sl.customer_id = cu.customer_id)))
  GROUP BY cu.customer_name, sl.customer_id, cu.customer_age, cu.customer_gender, cu.customer_city
  ORDER BY (sum(sl.totalsales)) DESC
 LIMIT 10;
 ,   DROP VIEW public.top10productosmasvendidos;
       public          postgres    false    216    216    216    216    216    218    218         ?          0    17288 	   campaigns 
   TABLE DATA           j   COPY public.campaigns (campaign_id, campaign_type, campaign_mediatype, startdate, finishdate) FROM stdin;
    public          postgres    false    214       3391.dat @          0    17293    category 
   TABLE DATA           T   COPY public.category (category_id, category_name, category_description) FROM stdin;
    public          postgres    false    215       3392.dat A          0    17298 	   customers 
   TABLE DATA           �   COPY public.customers (customer_id, customer_name, customer_adress, customer_age, customer_city, customer_phone, customer_email, customer_gender) FROM stdin;
    public          postgres    false    216       3393.dat B          0    17303 	   employees 
   TABLE DATA           ~   COPY public.employees (employee_id, store_id, employee_name, employee_gender, employee_birthdate, employee_phone) FROM stdin;
    public          postgres    false    217       3394.dat C          0    17308 
   fact_sales 
   TABLE DATA           y   COPY public.fact_sales (sales_id, customer_id, employee_id, shipment_id, campaign_id, salesdate, totalsales) FROM stdin;
    public          postgres    false    218       3395.dat D          0    17313 	   inventory 
   TABLE DATA           p   COPY public.inventory (inventory_id, product_id, product_sold, product_quantity, product_available) FROM stdin;
    public          postgres    false    219       3396.dat E          0    17316    products 
   TABLE DATA           e   COPY public.products (product_id, supplier_id, category_id, product_name, product_price) FROM stdin;
    public          postgres    false    220       3397.dat F          0    17321    salesdetails 
   TABLE DATA           i   COPY public.salesdetails (salesdetails_id, sales_id, product_id, store_id, product_quantity) FROM stdin;
    public          postgres    false    221       3398.dat G          0    17324    shipment 
   TABLE DATA           L   COPY public.shipment (shipment_id, shipper_name, shipper_phone) FROM stdin;
    public          postgres    false    222       3399.dat H          0    17329    stores 
   TABLE DATA           D   COPY public.stores (store_id, store_adress, store_type) FROM stdin;
    public          postgres    false    223       3400.dat I          0    17334 	   suppliers 
   TABLE DATA           �   COPY public.suppliers (supplier_id, supplier_name, supplier_adress, supplier_country, supplier_email, supplier_phone) FROM stdin;
    public          postgres    false    224       3401.dat �           2606    17340    campaigns campaigns_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_id);
 B   ALTER TABLE ONLY public.campaigns DROP CONSTRAINT campaigns_pkey;
       public            postgres    false    214         �           2606    17342    category category_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    215         �           2606    17344    customers customers_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    216         �           2606    17346    employees employees_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    217         �           2606    17348    inventory inventory_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public            postgres    false    219         �           2606    17350    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    220         �           2606    17352    fact_sales sales_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.fact_sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sales_id);
 ?   ALTER TABLE ONLY public.fact_sales DROP CONSTRAINT sales_pkey;
       public            postgres    false    218         �           2606    17354    salesdetails salesdetails_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.salesdetails
    ADD CONSTRAINT salesdetails_pkey PRIMARY KEY (salesdetails_id);
 H   ALTER TABLE ONLY public.salesdetails DROP CONSTRAINT salesdetails_pkey;
       public            postgres    false    221         �           2606    17356    shipment shipment_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);
 @   ALTER TABLE ONLY public.shipment DROP CONSTRAINT shipment_pkey;
       public            postgres    false    222         �           2606    17358    stores stores_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);
 <   ALTER TABLE ONLY public.stores DROP CONSTRAINT stores_pkey;
       public            postgres    false    223         �           2606    17360    suppliers suppliers_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);
 B   ALTER TABLE ONLY public.suppliers DROP CONSTRAINT suppliers_pkey;
       public            postgres    false    224                                                                                                                                                                                                                                                                                                                                                                                    3391.dat                                                                                            0000600 0004000 0002000 00000000404 14501220317 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	20% discount on your next sale  for 500 dollars spent	social media	2022-08-01	2022-08-30
2	Get a free TV 60' for 2000 dollars spent	TV commercial	2022-10-01	2022-10-31
3	get a free trip all paid for purchases over $ 3000	newspaper	2023-01-01	2023-01-15
\.


                                                                                                                                                                                                                                                            3392.dat                                                                                            0000600 0004000 0002000 00000000542 14501220317 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Beverages	Soft drinks, coffees, teas, beers, and ales
2	Condiments	Sweet and savory sauces, relishes, spreads, and seasonings
3	Confections	Desserts, candies, and sweet breads
4	Dairy Products	Cheeses
5	Grains/Cereals	Breads, crackers, pasta, and cereal
6	Meat/Poultry	Prepared meats
7	Produce	Dried fruit and bean curd
8	Seafood	Seaweed and fish
\.


                                                                                                                                                              3393.dat                                                                                            0000600 0004000 0002000 00000010146 14501220317 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Maria Anders	Obere Str. 57	37	Berlin	 434-3259	Maria@gmail.com	FEMALE
2	Ana Trujillo	Avda. de la Constitución 2222	32	México D.F.	 434-3260	Ana@gmail.com	FEMALE
3	Antonio Moreno	Mataderos 2312	42	México D.F.	  534-3261	Antonio@gmail.com	MALE
4	Thomas Hardy	120 Hanover Sq.	33	London	  234-3262	Thomas@gmail.com	MALE
5	Christina Berglund	Berguvsvägen 8	36	Luleå	  334-3263	Christina@gmail.com	FEMALE
6	Hanna Moos	Forsterstr. 57	24	Mannheim	  634-3264	Hanna@gmail.com	FEMALE
7	Frédérique Citeaux	24, place Kléber	27	Strasbourg	  534-3265	Frédérique@gmail.com	MALE
8	Martín Sommer	C/ Araquil, 67	26	Madrid	  434-3266	Martín@gmail.com	MALE
9	Laurence Lebihans	12, rue des Bouchers	34	Marseille	  534-3267	Laurence@gmail.com	MALE
10	Elizabeth Lincoln	23 Tsawassen Blvd.	38	Tsawassen	  434-3268	Elizabeth@gmail.com	FEMALE
11	Victoria Ashworth	Fauntleroy Circus	36	London	  434-3269	Victoria@gmail.com	FEMALE
12	Patricio Simpson	Cerrito 333	33	Buenos Aires	  434-3270	Patricio@gmail.com	MALE
13	Francisco Chang	Sierras de Granada 9993	36	México D.F.	  434-3271	Francisco@gmail.com	MALE
14	Yang Wang	Hauptstr. 29	37	Bern	  434-3272	Yang@gmail.com	MALE
15	Pedro Afonso	Av. dos Lusíadas, 23	39	São Paulo	  434-3273	Pedro@gmail.com	MALE
16	Elizabeth Brown	Berkeley Gardens 12 Brewery	22	London	  434-3274	Elizabeth@gmail.com	FEMALE
17	Sven Ottlieb	Walserweg 21	24	Aachen	  434-3275	Sven@gmail.com	MALE
18	Janine Labrune	67, rue des Cinquante Otages	38	Nantes	  434-3276	Janine@gmail.com	FEMALE
19	Ann Devon	35 King George	37	London	  434-3277	Ann@gmail.com	FEMALE
20	Roland Mendel	Kirchgasse 6	23	Graz	  434-3278	Roland@gmail.com	MALE
21	Aria Cruz	Rua Orós, 92	22	São Paulo	  434-3279	Aria@gmail.com	FEMALE
22	Diego Roel	C/ Moralzarzal, 86	26	Madrid	  434-3280	Diego@gmail.com	MALE
23	Martine Rancé	184, chaussée de Tournai	31	Lille	  434-3281	Martine@gmail.com	FEMALE
24	Maria Larsson	Åkergatan 24	31	Bräcke	  434-3282	Maria@gmail.com	FEMALE
25	Peter Franken	Berliner Platz 43	39	München	  434-3283	Peter@gmail.com	MALE
26	Carine Schmitt	54, rue Royale	30	Nantes	  434-3284	Carine@gmail.com	FEMALE
27	Paolo Accorti	Via Monte Bianco 34	29	Torino	  434-3285	Paolo@gmail.com	MALE
28	Lino Rodriguez	Jardim das rosas n. 32	41	Lisboa	  434-3286	Lino@gmail.com	MALE
29	Eduardo Saavedra	Rambla de Cataluña, 23	34	Barcelona	  434-3287	Eduardo@gmail.com	MALE
30	José Pedro Freyre	C/ Romero, 33	28	Sevilla	  434-3288	José@gmail.com	MALE
31	André Fonseca	Av. Brasil, 442	40	Campinas	  434-3289	André@gmail.com	MALE
32	Howard Snyder	2732 Baker Blvd.	37	Eugene	  434-3290	Howard@gmail.com	MALE
33	Manuel Pereira	5ª Ave. Los Palos Grandes	24	Caracas	  434-3291	Manuel@gmail.com	MALE
34	Mario Pontes	Rua do Paço, 67	29	Rio de Janeiro	  434-3292	Mario@gmail.com	MALE
35	Carlos Hernández	Carrera 22 con Ave. Carlos Soublette #8-35	41	San Cristóbal	  434-3293	Carlos@gmail.com	MALE
36	Yoshi Latimer	City Center Plaza 516 Main St.	25	Elgin	  434-3294	Yoshi@gmail.com	MALE
37	Patricia McKenna	8 Johnstown Road	29	Cork	  434-3295	Patricia@gmail.com	FEMALE
38	Helen Bennett	Garden House Crowther Way	33	Cowes	  434-3296	Helen@gmail.com	FEMALE
39	Philip Cramer	Maubelstr. 90	27	Brandenburg	  434-3297	Philip@gmail.com	MALE
40	Daniel Tonini	67, avenue de l''Europe	25	Versailles	  434-3298	Daniel@gmail.com	MALE
41	Annette Roulet	1 rue Alsace-Lorraine	22	Toulouse	  434-3299	Annette@gmail.com	FEMALE
42	Yoshi Tannamuri	1900 Oak St.	42	Vancouver	  434-3300	Yoshi@gmail.com	MALE
43	John Steel	12 Orchestra Terrace	26	Walla Walla	  434-3301	John@gmail.com	MALE
44	Renate Messner	Magazinweg 7	22	Frankfurt a.M.	  434-3302	Renate@gmail.com	MALE
45	Jaime Yorres	87 Polk St. Suite 5	29	San Francisco	  434-3303	Jaime@gmail.com	MALE
46	Carlos González	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	25	Barquisimeto	  434-3304	Carlos@gmail.com	MALE
47	Felipe Izquierdo	Ave. 5 de Mayo Porlamar	35	I. de Margarita	  434-3305	Felipe@gmail.com	MALE
48	Fran Wilson	89 Chiaroscuro Rd.	39	Portland	  434-3306	Fran@gmail.com	MALE
49	Giovanni Rovelli	Via Ludovico il Moro 22	24	Bergamo	  434-3307	Giovanni@gmail.com	MALE
50	Catherine Dewey	Rue Joseph-Bens 532	42	Bruxelles	  434-3308	Catherine@gmail.com	FEMALE
\.


                                                                                                                                                                                                                                                                                                                                                                                                                          3394.dat                                                                                            0000600 0004000 0002000 00000000667 14501220317 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2	Nancy Davolio	FEMALE	1968-12-08	345-456
2	2	Andrew Fuller	MALE	1952-02-19	345-457
3	1	Janet Leverling	FEMALE	1963-08-30	345-458
4	1	Margaret Peacock	FEMALE	1958-09-19	345-459
5	1	Steven Gomez	MALE	1955-03-04	345-460
6	1	Michael Martin	MALE	1963-07-02	345-461
7	2	Roberto Reyes	MALE	1960-05-29	345-462
8	2	Laura Martinez	FEMALE	1958-01-09	345-463
9	1	Anne Dodsworth	FEMALE	1969-07-02	345-464
10	1	Adam West	MALE	1928-09-19	345-465
\.


                                                                         3395.dat                                                                                            0000600 0004000 0002000 00000014111 14501220317 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10248	37	5	3	0	2022-07-04	566
10249	23	6	1	0	2022-07-05	2329.25
10250	19	4	2	0	2022-07-08	2267.25
10251	47	3	1	0	2022-07-08	839.5
10252	17	4	2	0	2022-07-09	4662.5
10253	27	3	2	0	2022-07-10	1806
10254	7	5	2	0	2022-07-11	781.5
10255	12	9	3	0	2022-07-12	3115.75
10256	11	3	2	0	2022-07-15	648
10257	29	4	3	0	2022-07-16	1400.5
10258	48	1	1	0	2022-07-17	2529.75
10259	11	4	3	0	2022-07-18	126
10260	1	4	1	0	2022-07-19	2183.9
10261	3	4	2	0	2022-07-19	560
10262	2	8	3	0	2022-07-22	782.2
10263	12	9	3	0	2022-07-23	3086.4
10264	30	6	3	0	2022-07-24	906.25
10265	8	2	1	0	2022-07-25	1470
10266	17	3	3	0	2022-07-26	456
10267	23	4	1	0	2022-07-29	5040
10268	20	8	3	0	2022-07-30	1377.1
10269	1	5	1	0	2022-07-31	846
10270	17	1	1	0	2022-08-01	1720
10271	14	6	2	0	2022-08-01	60
10272	22	6	2	1	2022-08-02	1821.2
10273	27	3	3	1	2022-08-05	2679.5
10274	37	6	1	1	2022-08-06	673.6
10275	2	1	1	0	2022-08-07	384
10276	44	8	3	1	2022-08-08	525
10277	26	2	3	1	2022-08-09	1503.6
10278	31	8	2	1	2022-08-12	1862.4
10279	22	8	2	1	2022-08-13	585
10280	37	2	1	1	2022-08-14	766.5
10281	17	4	1	0	2022-08-14	108.2
10282	27	4	1	0	2022-08-15	194.34
10283	23	3	3	1	2022-08-16	1770
10284	29	4	1	1	2022-08-19	1816.95
10285	50	1	2	1	2022-08-20	2726.8
10286	5	8	3	1	2022-08-21	3772
10287	22	8	3	1	2022-08-22	1158
10288	30	4	1	0	2022-08-23	112
10289	40	7	3	1	2022-08-26	599.25
10290	1	8	1	1	2022-08-27	2713.85
10291	19	6	2	1	2022-08-27	692.8
10292	25	1	2	1	2022-08-28	1620
10293	13	1	3	1	2022-08-29	1061
10294	32	4	2	1	2022-08-30	2359.5
10295	46	2	2	0	2022-09-02	152
10296	21	6	1	0	2022-09-03	1315.5
10297	19	5	2	0	2022-09-04	1776
10298	21	6	2	0	2022-09-05	3909.5
10299	1	4	2	0	2022-09-06	438
10300	14	2	2	0	2022-09-09	760
10301	10	8	2	0	2022-09-09	944
10302	36	4	2	0	2022-09-10	3388.8
10303	8	7	2	0	2022-09-11	1555
10304	44	1	2	0	2022-09-12	1193
10305	21	8	3	0	2022-09-13	5197.25
10306	44	1	3	0	2022-09-16	624.15
10307	19	2	2	0	2022-09-17	530.5
10308	37	7	3	0	2022-09-18	111
10309	36	3	1	0	2022-09-19	2202.5
10310	45	8	2	0	2022-09-20	421
10311	11	1	3	0	2022-09-20	336
10312	4	2	2	0	2022-09-23	2019.9
10313	20	2	2	0	2022-09-24	228
10314	1	1	2	0	2022-09-25	2910
10315	36	4	2	0	2022-09-26	646
10316	4	1	3	0	2022-09-27	3547.5
10317	16	6	1	0	2022-09-30	360
10318	13	8	2	0	2022-10-01	301
10319	14	7	3	0	2022-10-02	1490.4
10320	17	5	3	0	2022-10-03	645
10321	47	3	2	0	2022-10-03	180
10322	35	7	3	0	2022-10-04	140
10323	20	4	1	0	2022-10-07	205.5
10324	40	9	1	2	2022-10-08	7698.45
10325	18	1	3	0	2022-10-09	1873.25
10326	16	4	2	0	2022-10-10	1227.5
10327	47	2	1	2	2022-10-11	2828.65
10328	28	4	3	0	2022-10-14	1462
10329	39	4	2	2	2022-10-15	6025.12
10330	45	3	1	2	2022-10-16	2431.5
10331	11	9	1	2	2022-10-16	111.75
10332	25	3	2	2	2022-10-17	2792
10333	5	5	3	0	2022-10-18	1192.5
10334	35	8	2	0	2022-10-21	181
10335	47	7	2	2	2022-10-22	3181.5
10336	33	7	2	0	2022-10-23	396
10337	48	4	3	2	2022-10-24	3087.52
10338	9	4	3	0	2022-10-25	1168.35
10339	47	2	2	2	2022-10-28	4330.4
10340	30	1	3	2	2022-10-29	3205.8
10341	26	7	3	0	2022-10-29	515
10342	18	4	2	2	2022-10-30	2876
10343	29	4	1	0	2022-10-31	1982.5
10344	45	4	2	0	2022-11-01	3570
10345	7	2	2	0	2022-11-04	3662
10346	35	3	3	0	2022-11-05	2164
10347	44	4	3	0	2022-11-06	1160.1
10348	31	4	2	0	2022-11-07	495
10349	27	7	1	0	2022-11-08	178.8
10350	35	6	2	0	2022-11-11	891.75
10351	35	1	1	0	2022-11-11	7103.6
10352	4	3	3	0	2022-11-12	194
10353	1	7	3	0	2022-11-13	13427
10354	39	8	3	0	2022-11-14	711.16
10355	23	6	1	0	2022-11-15	600
10356	5	6	2	0	2022-11-18	1383
10357	12	1	3	0	2022-11-19	1701.68
10358	3	5	1	0	2022-11-20	565
10359	26	5	3	0	2022-11-21	4572.2
10360	48	4	3	0	2022-11-22	9244.25
10361	33	1	2	0	2022-11-22	2842
10362	24	3	1	0	2022-11-25	1938.8
10363	14	4	3	0	2022-11-26	559
10364	12	1	1	0	2022-11-26	1187.5
10365	10	3	2	0	2022-11-27	504
10366	36	8	2	0	2022-11-28	170.25
10367	22	7	3	0	2022-11-28	1044.85
10368	7	2	2	0	2022-11-29	2294.05
10369	25	8	2	0	2022-12-02	3159.8
10370	21	6	2	0	2022-12-03	1467.5
10371	50	1	1	0	2022-12-03	114
10372	7	5	2	0	2022-12-04	15353.6
10373	6	4	3	0	2022-12-05	2135
10374	32	1	3	0	2022-12-05	573.75
10375	50	3	2	0	2022-12-06	423.25
10376	42	1	2	0	2022-12-09	525
10377	36	1	3	0	2022-12-09	1272
10378	32	5	3	0	2022-12-10	129
10379	49	2	1	0	2022-12-11	1200.6
10380	26	8	3	0	2022-12-12	1776.02
10381	14	3	3	0	2022-12-12	140
10382	20	4	1	0	2022-12-13	3628.76
10383	35	8	3	0	2022-12-16	1123.75
10384	24	3	3	0	2022-12-16	2778
10385	19	1	2	0	2022-12-17	1080
10386	10	9	3	0	2022-12-18	207.5
10387	8	1	2	0	2022-12-18	1323.6
10388	12	2	1	0	2022-12-19	1594.5
10389	39	4	2	0	2022-12-20	2292
10390	27	6	1	0	2022-12-23	2845.2
10391	29	3	3	0	2022-12-23	108
10392	7	2	3	0	2022-12-24	1800
10393	33	1	3	0	2022-12-25	4135.6
10394	13	1	3	0	2022-12-25	553
10395	41	6	1	0	2022-12-26	2920
10396	34	1	3	0	2022-12-27	2380.8
10397	45	5	1	0	2022-12-27	1054
10398	4	2	3	0	2022-12-30	3420
10399	14	8	3	0	2022-12-31	2207
10400	34	1	3	3	2022-01-01	3829.59
10401	8	1	1	3	2023-01-01	4837.02
10402	49	8	2	3	2023-01-02	3393.5
10403	30	4	3	0	2023-01-03	1258.95
10404	34	2	1	0	2023-01-03	2096.9
10405	43	1	1	0	2023-01-06	500
10406	26	7	1	0	2023-01-07	2527
10407	8	2	2	0	2023-01-07	1492.5
10408	38	8	1	0	2023-01-08	2030.2
10409	44	3	1	0	2023-01-09	399
10410	33	3	3	0	2023-01-10	1002.5
10411	8	9	3	0	2023-01-10	1514.25
10412	20	8	2	0	2023-01-13	465
10413	40	3	2	0	2023-01-14	2656
10414	10	2	3	0	2023-01-14	290.6
10415	29	3	1	0	2023-01-15	128
10416	16	8	3	0	2023-01-16	902
10417	41	4	3	3	2023-01-16	14104
10418	46	4	1	0	2023-01-17	2268.5
10419	4	4	2	0	2023-01-20	2760
10420	47	3	1	0	2023-01-21	2372
10421	14	8	1	0	2023-01-21	1595.7
10422	1	2	1	0	2023-01-22	62.46
10423	15	6	3	0	2023-01-23	1275
10424	20	7	2	3	2023-01-23	14366.5
10425	34	6	2	0	2023-01-24	600
10426	36	4	1	0	2023-01-27	422.75
10427	9	4	2	0	2023-01-27	813.75
10428	44	7	1	0	2023-01-28	240
10429	35	3	2	0	2023-01-29	2186.5
10430	41	4	1	3	2023-01-30	7245
10431	9	4	2	3	2023-01-30	3155
10432	50	10	2	0	2023-01-31	610.3
10433	44	10	3	0	2023-02-03	1064
10434	49	10	2	0	2023-02-03	450
10435	27	8	2	0	2023-02-04	790
10436	45	3	2	0	2023-02-05	2763.5
10437	8	8	1	0	2023-02-05	492
10438	20	3	2	0	2023-02-06	710.5
10439	27	6	3	0	2023-02-07	1348.7
10440	41	4	2	0	2023-02-10	7246.01
10441	2	3	2	0	2023-02-10	2195
10442	42	10	2	0	2023-02-11	2246
10443	23	8	1	0	2023-02-12	673.2
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                       3396.dat                                                                                            0000600 0004000 0002000 00000002651 14501220317 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1001	1	159	200	41
1002	2	341	341	0
1003	3	80	85	5
1004	4	107	200	93
1005	5	129	200	71
1006	6	36	80	44
1007	7	25	55	30
1008	8	140	250	110
1009	9	20	62	42
1010	10	85	150	65
1011	11	182	182	0
1012	12	27	80	53
1013	13	92	150	58
1014	14	152	153	1
1015	15	25	45	20
1016	16	338	400	62
1017	17	331	331	0
1018	18	106	200	94
1019	19	181	200	19
1020	20	106	200	94
1021	21	147	200	53
1022	22	18	45	27
1023	23	165	200	35
1024	24	158	225	67
1025	25	71	300	229
1026	26	232	300	68
1027	27	90	300	210
1028	28	189	300	111
1029	29	168	300	132
1030	30	170	180	10
1031	31	458	500	42
1032	32	52	150	98
1033	33	316	400	84
1034	34	110	200	90
1035	35	369	500	131
1036	36	198	198	0
1037	37	39	80	41
1038	38	239	345	106
1039	39	266	266	0
1040	40	256	300	44
1041	41	139	250	111
1042	42	77	150	73
1043	43	136	200	64
1044	44	178	300	122
1045	45	15	100	85
1046	46	145	200	55
1047	47	101	200	99
1048	48	70	200	130
1049	49	180	300	120
1050	50	70	70	0
1051	51	163	300	137
1052	52	48	200	152
1053	53	251	400	149
1054	54	280	400	120
1055	55	238	400	162
1056	56	269	400	131
1057	57	168	400	232
1058	58	155	400	245
1059	59	346	500	154
1060	60	430	500	70
1061	61	106	300	194
1062	62	325	500	175
1063	63	209	500	291
1064	64	167	300	133
1065	65	175	400	225
1066	66	90	100	10
1067	67	5	50	45
1068	68	199	300	101
1069	69	184	300	116
1070	70	164	400	236
1071	71	336	500	164
1072	72	270	270	0
1073	73	45	45	0
1074	74	186	300	114
1075	75	144	300	156
1076	76	198	300	102
1077	77	108	250	142
\.


                                                                                       3397.dat                                                                                            0000600 0004000 0002000 00000004540 14501220317 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1	Chais	18.00
2	1	1	Chang	19.00
3	1	2	Aniseed Syrup	10.00
4	2	2	Chef Anton's Cajun Seasoning	22.00
5	2	2	Chef Anton's Gumbo Mix	21.35
6	3	2	Grandma's Boysenberry Spread	25.00
7	3	7	Uncle Bob's Organic Dried Pears	30.00
8	3	2	Northwoods Cranberry Sauce	40.00
9	4	6	Mishi Kobe Niku	97.00
10	4	8	Ikura	31.00
11	5	4	Queso Cabrales	21.00
12	5	4	Queso Manchego La Pastora	38.00
13	6	8	Konbu	6.00
14	6	7	Tofu	23.25
15	6	2	Genen Shouyu	15.50
16	7	3	Pavlova	17.45
17	7	6	Alice Mutton	39.00
18	7	8	Carnarvon Tigers	62.50
19	8	3	Teatime Chocolate Biscuits	9.20
20	8	3	Sir Rodney's Marmalade	81.00
21	8	3	Sir Rodney's Scones	10.00
22	9	5	Gustaf's Knäckebröd	21.00
23	9	5	Tunnbröd	9.00
24	10	1	Guaraná Fantástica	4.50
25	11	3	NuNuCa Nuß-Nougat-Creme	14.00
26	11	3	Gumbär Gummibärchen	31.23
27	11	3	Schoggi Schokolade	43.90
28	12	7	Rössle Sauerkraut	45.60
29	12	6	Thüringer Rostbratwurst	123.79
30	13	8	Nord-Ost Matjeshering	25.89
31	14	4	Gorgonzola Telino	12.50
32	14	4	Mascarpone Fabioli	32.00
33	15	4	Geitost	2.50
34	16	1	Sasquatch Ale	14.00
35	16	1	Steeleye Stout	18.00
36	17	8	Inlagd Sill	19.00
37	17	8	Gravad lax	26.00
38	18	1	Côte de Blaye	263.50
39	18	1	Chartreuse verte	18.00
40	19	8	Boston Crab Meat	18.40
41	19	8	Jack's New England Clam Chowder	9.65
42	20	5	Singaporean Hokkien Fried Mee	14.00
43	20	1	Ipoh Coffee	46.00
44	20	2	Gula Malacca	19.45
45	21	8	Røgede sild	9.50
46	21	8	Spegesild	12.00
47	22	3	Zaanse koeken	9.50
48	22	3	Chocolade	12.75
49	23	3	Maxilaku	20.00
50	23	3	Valkoinen suklaa	16.25
51	24	7	Manjimup Dried Apples	53.00
52	24	5	Filo Mix	7.00
53	24	6	Perth Pasties	32.80
54	25	6	Tourtière	7.45
55	25	6	Pâté chinois	24.00
56	26	5	Gnocchi di nonna Alice	38.00
57	26	5	Ravioli Angelo	19.50
58	27	8	Escargots de Bourgogne	13.25
59	28	4	Raclette Courdavault	55.00
60	28	4	Camembert Pierrot	34.00
61	29	2	Sirop d'érable	28.50
62	29	3	Tarte au sucre	49.30
63	7	2	Vegie-spread	43.90
64	12	5	Wimmers gute Semmelknödel	33.25
65	2	2	Louisiana Fiery Hot Pepper Sauce	21.05
66	2	2	Louisiana Hot Spiced Okra	17.00
67	16	1	Laughing Lumberjack Lager	14.00
68	8	3	Scottish Longbreads	12.50
69	15	4	Gudbrandsdalsost	36.00
70	7	1	Outback Lager	15.00
71	15	4	Fløtemysost	21.50
72	14	4	Mozzarella di Giovanni	34.80
73	17	8	Röd Kaviar	15.00
74	4	7	Longlife Tofu	10.00
75	12	1	Rhönbräu Klosterbier	7.75
76	23	1	Lakkalikööri	18.00
77	12	2	Original Frankfurter grüne Soße	13.00
\.


                                                                                                                                                                3398.dat                                                                                            0000600 0004000 0002000 00000021612 14501220317 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	10248	11	1	12
2	10248	42	1	10
3	10248	72	1	5
4	10249	14	2	9
5	10249	51	2	40
6	10250	41	2	10
7	10250	51	2	35
8	10250	65	2	15
9	10251	22	1	6
10	10251	57	1	15
11	10251	65	1	20
12	10252	20	2	40
13	10252	33	2	25
14	10252	60	2	40
15	10253	31	1	20
16	10253	39	1	42
17	10253	49	1	40
18	10254	24	2	15
19	10254	55	2	21
20	10254	74	2	21
21	10255	2	2	20
22	10255	16	2	35
23	10255	36	2	25
24	10255	59	2	30
25	10256	53	1	15
26	10256	77	1	12
27	10257	27	1	25
28	10257	39	1	6
29	10257	77	1	15
30	10258	2	1	50
31	10258	5	1	65
32	10258	32	1	6
33	10259	21	1	10
34	10259	37	1	1
35	10260	41	1	16
36	10260	57	1	50
37	10260	62	1	15
38	10260	70	1	21
39	10261	21	1	20
40	10261	35	1	20
41	10262	5	1	12
42	10262	7	1	15
43	10262	56	1	2
44	10263	16	1	60
45	10263	24	1	28
46	10263	30	1	60
47	10263	74	1	36
48	10264	2	2	35
49	10264	41	2	25
50	10265	17	2	30
51	10265	70	2	20
52	10266	12	2	12
53	10267	40	2	50
54	10267	59	2	70
55	10267	76	2	15
56	10268	29	2	10
57	10268	72	2	4
58	10269	33	2	60
59	10269	72	2	20
60	10270	36	2	30
61	10270	43	2	25
62	10271	33	2	24
63	10272	20	2	6
64	10272	31	2	40
65	10272	72	2	24
66	10273	10	2	24
67	10273	31	2	15
68	10273	33	2	20
69	10273	40	2	60
70	10273	76	2	33
71	10274	71	2	20
72	10274	72	2	7
73	10275	24	1	12
74	10275	59	1	6
75	10276	10	1	15
76	10276	13	1	10
77	10277	28	1	20
78	10277	62	1	12
79	10278	44	1	16
80	10278	59	1	15
81	10278	63	1	8
82	10278	73	1	25
83	10279	17	1	15
84	10280	24	1	12
85	10280	55	1	20
86	10280	75	1	30
87	10281	19	1	1
88	10281	24	1	6
89	10281	35	1	4
90	10282	30	1	6
91	10282	57	1	2
92	10283	15	1	20
93	10283	19	1	18
94	10283	60	1	35
95	10283	72	1	3
96	10284	27	1	15
97	10284	44	1	21
98	10284	60	1	20
99	10284	67	1	5
100	10285	1	1	45
101	10285	40	1	40
102	10285	53	1	36
103	10286	35	1	100
104	10286	62	1	40
105	10287	16	2	40
106	10287	34	2	20
107	10287	46	2	15
108	10288	54	2	10
109	10288	68	2	3
110	10289	3	2	30
111	10289	64	2	9
112	10290	5	1	20
113	10290	29	1	15
114	10290	49	1	15
115	10290	77	1	10
116	10291	13	1	20
117	10291	44	1	24
118	10291	51	1	2
119	10292	20	1	20
120	10293	18	1	12
121	10293	24	1	10
122	10293	63	1	5
123	10293	75	1	6
124	10294	1	1	18
125	10294	17	1	15
126	10294	43	1	15
127	10294	60	1	21
128	10294	75	1	6
129	10295	56	1	4
130	10296	11	1	12
131	10296	16	1	30
132	10296	69	1	15
133	10297	39	1	60
134	10297	72	1	20
135	10298	2	1	40
136	10298	36	1	40
137	10298	59	1	30
138	10298	62	1	15
139	10299	19	2	15
140	10299	70	2	20
141	10300	66	2	30
142	10300	68	2	20
143	10301	40	1	10
144	10301	56	1	20
145	10302	17	1	40
146	10302	28	1	28
147	10302	43	1	12
148	10303	40	1	40
149	10303	65	1	30
150	10303	68	1	15
151	10304	49	2	30
152	10304	59	2	10
153	10304	71	2	2
154	10305	18	2	25
155	10305	29	2	25
156	10305	39	2	30
157	10306	30	2	10
158	10306	53	2	10
159	10306	54	2	5
160	10307	62	2	10
161	10307	68	2	3
162	10308	69	2	1
163	10308	70	2	5
164	10309	4	2	20
165	10309	6	2	30
166	10309	42	2	2
167	10309	43	2	20
168	10309	71	2	3
169	10310	16	2	10
170	10310	62	2	5
171	10311	42	2	6
172	10311	69	2	7
173	10312	28	2	4
174	10312	43	2	24
175	10312	53	2	20
176	10312	75	2	10
177	10313	36	1	12
178	10314	32	1	40
179	10314	58	1	30
180	10314	62	1	25
181	10315	34	1	14
182	10315	70	1	30
183	10316	41	1	10
184	10316	62	1	70
185	10317	1	1	20
186	10318	41	1	20
187	10318	76	1	6
188	10319	17	1	8
189	10319	28	1	14
190	10319	76	1	30
191	10320	71	1	30
192	10321	35	1	10
193	10322	52	1	20
194	10323	15	1	5
195	10323	25	1	4
196	10323	39	1	4
197	10324	16	1	21
198	10324	35	1	70
199	10324	46	1	30
200	10324	59	1	40
201	10324	63	1	80
202	10325	6	1	6
203	10325	13	1	12
204	10325	14	1	9
205	10325	31	1	4
206	10325	72	1	40
207	10326	4	1	24
208	10326	57	1	16
209	10326	75	1	50
210	10327	2	1	25
211	10327	11	1	50
212	10327	30	1	35
213	10327	58	1	30
214	10328	59	1	9
215	10328	65	1	40
216	10328	68	1	10
217	10329	19	1	10
218	10329	30	1	8
219	10329	38	1	20
220	10329	56	1	12
221	10330	26	1	50
222	10330	72	1	25
223	10331	54	1	15
224	10332	18	1	40
225	10332	42	1	10
226	10332	47	1	16
227	10333	14	1	10
228	10333	21	1	10
229	10333	71	1	40
230	10334	52	1	8
231	10334	68	1	10
232	10335	2	1	7
233	10335	31	1	25
234	10335	32	1	6
235	10335	51	1	48
236	10336	4	1	18
237	10337	23	1	40
238	10337	26	1	24
239	10337	36	1	20
240	10337	37	1	28
241	10337	72	1	25
242	10338	17	1	20
243	10338	30	1	15
244	10339	4	1	10
245	10339	17	1	70
246	10339	62	1	28
247	10340	18	1	20
248	10340	41	1	12
249	10340	43	1	40
250	10341	33	1	8
251	10341	59	1	9
252	10342	2	1	24
253	10342	31	1	56
254	10342	36	1	40
255	10342	55	1	40
256	10343	64	1	50
257	10343	68	1	4
258	10343	76	1	15
259	10344	4	1	35
260	10344	8	1	70
261	10345	8	1	70
262	10345	19	1	80
263	10345	42	1	9
264	10346	17	1	36
265	10346	56	1	20
266	10347	25	1	10
267	10347	39	1	50
268	10347	40	1	4
269	10347	75	1	6
270	10348	1	1	15
271	10348	23	1	25
272	10349	54	1	24
273	10350	50	1	15
274	10350	69	1	18
275	10351	38	1	20
276	10351	41	1	13
277	10351	44	1	77
278	10351	65	1	10
279	10352	24	1	10
280	10352	54	1	20
281	10353	11	1	12
282	10353	38	1	50
283	10354	1	1	12
284	10354	29	1	4
285	10355	24	1	25
286	10355	57	1	25
287	10356	31	1	30
288	10356	55	1	12
289	10356	69	1	20
290	10357	10	1	30
291	10357	26	1	16
292	10357	60	1	8
293	10358	24	1	10
294	10358	34	1	10
295	10358	36	1	20
296	10359	16	1	56
297	10359	31	1	70
298	10359	60	1	80
299	10360	28	1	30
300	10360	29	1	35
301	10360	38	1	10
302	10360	49	1	35
303	10360	54	1	28
304	10361	39	1	54
305	10361	60	1	55
306	10362	25	1	50
307	10362	51	1	20
308	10362	54	1	24
309	10363	31	1	20
310	10363	75	1	12
311	10363	76	1	12
312	10364	69	1	30
313	10364	71	1	5
314	10365	11	1	24
315	10366	65	1	5
316	10366	77	1	5
317	10367	34	1	36
318	10367	54	1	18
319	10367	65	1	15
320	10367	77	1	7
321	10368	21	1	5
322	10368	28	1	13
323	10368	57	1	25
324	10368	64	1	35
325	10369	29	1	20
326	10369	56	1	18
327	10370	1	1	15
328	10370	64	1	30
329	10370	74	1	20
330	10371	36	1	6
331	10372	20	1	12
332	10372	38	1	40
333	10372	60	1	70
334	10372	72	1	42
335	10373	58	1	80
336	10373	71	1	50
337	10374	31	1	30
338	10374	58	1	15
339	10375	14	1	15
340	10375	54	1	10
341	10376	31	1	42
342	10377	28	1	20
343	10377	39	1	20
344	10378	71	1	6
345	10379	41	1	8
346	10379	63	1	16
347	10379	65	1	20
348	10380	30	1	18
349	10380	53	1	20
350	10380	60	1	6
351	10380	70	1	30
352	10381	74	1	14
353	10382	5	1	32
354	10382	18	1	9
355	10382	29	1	14
356	10382	33	1	60
357	10382	74	1	50
358	10383	13	1	20
359	10383	50	1	15
360	10383	56	1	20
361	10384	20	1	28
362	10384	60	1	15
363	10385	7	1	10
364	10385	60	1	20
365	10385	68	1	8
366	10386	24	1	15
367	10386	34	1	10
368	10387	24	1	15
369	10387	28	1	6
370	10387	59	1	12
371	10387	71	1	15
372	10388	45	1	15
373	10388	52	1	20
374	10388	53	1	40
375	10389	10	2	16
376	10389	55	2	15
377	10389	62	2	20
378	10389	70	2	30
379	10390	31	2	60
380	10390	35	2	40
381	10390	46	2	45
382	10390	72	2	24
383	10391	13	2	18
384	10392	69	2	50
385	10393	2	2	25
386	10393	14	2	42
387	10393	25	2	7
388	10393	26	2	70
389	10393	31	2	32
390	10394	13	2	10
391	10394	62	2	10
392	10395	46	2	28
393	10395	53	2	70
394	10395	69	2	8
395	10396	23	2	40
396	10396	71	2	60
397	10396	72	2	21
398	10397	21	2	10
399	10397	51	2	18
400	10398	35	1	30
401	10398	55	1	120
402	10399	68	1	60
403	10399	71	1	30
404	10399	76	1	35
405	10399	77	1	14
406	10400	29	1	21
407	10400	35	1	35
408	10400	49	1	30
409	10401	30	1	18
410	10401	56	1	70
411	10401	65	1	20
412	10401	71	1	60
413	10402	23	2	60
414	10402	63	2	65
415	10403	16	2	21
416	10403	48	2	70
417	10404	26	2	30
418	10404	42	2	40
419	10404	49	2	30
420	10405	3	2	50
421	10406	1	2	10
422	10406	21	2	30
423	10406	28	2	42
424	10406	36	2	5
425	10406	40	2	2
426	10407	11	2	30
427	10407	69	2	15
428	10407	71	2	15
429	10408	37	2	10
430	10408	54	2	6
431	10408	62	2	35
432	10409	14	2	12
433	10409	21	2	12
434	10410	33	2	49
435	10410	59	2	16
436	10411	41	1	25
437	10411	44	1	40
438	10411	59	1	9
439	10412	14	1	20
440	10413	1	1	24
441	10413	62	1	40
442	10413	76	1	14
443	10414	19	1	18
444	10414	33	1	50
445	10415	17	1	2
446	10415	33	1	20
447	10416	19	1	20
448	10416	53	1	10
449	10416	57	1	20
450	10417	38	1	50
451	10417	46	1	2
452	10417	68	1	36
453	10417	77	1	35
454	10418	2	1	60
455	10418	47	1	55
456	10418	61	1	16
457	10418	74	1	15
458	10419	60	1	60
459	10419	69	1	20
460	10420	9	1	20
461	10420	13	1	2
462	10420	70	1	8
463	10420	73	1	20
464	10421	19	1	4
465	10421	26	1	30
466	10421	53	1	15
467	10421	77	1	10
468	10422	26	1	2
469	10423	31	1	14
470	10423	59	1	20
471	10424	35	1	60
472	10424	38	1	49
473	10424	68	1	30
474	10425	55	1	10
475	10425	76	1	20
476	10426	56	1	5
477	10426	64	1	7
478	10427	14	1	35
479	10428	46	1	20
480	10429	50	1	40
481	10429	63	1	35
482	10430	17	1	45
483	10430	21	1	50
484	10430	56	1	30
485	10430	59	1	70
486	10431	17	1	50
487	10431	40	1	50
488	10431	47	1	30
489	10432	26	2	10
490	10432	54	2	40
491	10433	56	2	28
492	10434	11	2	6
493	10434	76	2	18
494	10435	2	2	10
495	10435	22	2	12
496	10435	72	2	10
497	10436	46	2	5
498	10436	56	2	40
499	10436	64	2	30
500	10436	75	2	24
501	10437	53	2	15
502	10438	19	2	15
503	10438	34	2	20
504	10438	57	2	15
505	10439	12	2	15
506	10439	16	2	16
507	10439	64	2	6
508	10439	74	2	30
509	10440	2	1	45
510	10440	16	1	49
511	10440	29	1	24
512	10440	61	1	90
513	10441	27	1	50
514	10442	11	1	30
515	10442	54	1	80
516	10442	66	1	60
517	10443	11	1	6
518	10443	28	1	12
\.


                                                                                                                      3399.dat                                                                                            0000600 0004000 0002000 00000000147 14501220317 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Speedy Express	(503) 555-9831
2	United Package	(503) 555-3199
3	Federal Shipping	(503) 555-9931
\.


                                                                                                                                                                                                                                                                                                                                                                                                                         3400.dat                                                                                            0000600 0004000 0002000 00000000147 14501220317 0014235 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	South House 300 Queensbridge, UK	physical store
2	www.internationalsmartmarket.com	online store
\.


                                                                                                                                                                                                                                                                                                                                                                                                                         3401.dat                                                                                            0000600 0004000 0002000 00000005034 14501220317 0014236 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Exotic Liquid	49 Gilbert St.	UK	Eliquid@gmail.com	(171) 555-2222
2	New Orleans Cajun Delights	P.O. Box 78934	USA	Norleanscajun@gmail.com	(100) 555-4822
3	Grandma Kelly's Homestead	707 Oxford Rd.	USA	Gkellys@gmail.com	(313) 555-5735
4	Tokyo Traders	9-8 Sekimai Musashino-shi	Japan	Ttraders@gmail.com	(03) 3555-5011
5	Cooperativa de Quesos 'Las Cabras'	Calle del Rosal 4	Spain	Cquesos@gmail.com	(98) 598 76 54
6	Mayumi's	92 Setsuko Chuo-ku	Japan	Mayumi@gmail.com	(06) 431-7877
7	Pavlova, Ltd.	74 Rose St. Moonie Ponds	Australia	Pavlova, Ltd.@gmail.com	(03) 444-2343
8	Specialty Biscuits, Ltd.	29 King's Way	UK	Specialty Biscuits, Ltd.@gmail.com	(161) 555-4448
9	PB Knäckebröd AB	Kaloadagatan 13	Sweden	PBkna@gmail.com	031-987 65 43
10	Refrescos Americanas LTDA	Av. das Americanas 12.890	Brazil	Ramericanas@gmail.com	(11) 555 4640
11	Heli Süßwaren GmbH & Co. KG	Tiergartenstraße 5	Germany	Heli Süßwaren GmbH & Co. KG@gmail.com	(010) 9984510
12	Plutzer Lebensmittelgroßmärkte AG	Bogenallee 51	Germany	Plutzer Lebensmittelgroßmärkte AG@gmail.com	(069) 992755
13	Nord-Ost-Fisch Handelsgesellschaft mbH	Frahmredder 112a	Germany	Nord-Ost-Fisch Handelsgesellschaft mbH@gmail.com	(04721) 8713
14	Formaggi Fortini s.r.l.	Viale Dante, 75	Italy	Formaggi Fortini s.r.l.@gmail.com	(0544) 60323
15	Norske Meierier	Hatlevegen 5	Norway	Morske@gmail.com	(0)2-953010
16	Bigfoot Breweries	3400 - 8th Avenue Suite 210	USA	Rbigfoot@gmail.com	(503) 555-9931
17	Svensk Sjöföda AB	Brovallavägen 231	Sweden	svensk@gmail.com	08-123 45 67
18	Aux joyeux ecclésiastiques	203, Rue des Francs-Bourgeois	France	Auxjoyeuxecclésiastiques@gmail.com	(1) 03.83.00.68
19	New England Seafood Cannery	Order Processing Dept. 2100 Paul Revere Blvd.	USA	New England Seafood Cannery@gmail.com	(617) 555-3267
20	Leka Trading	471 Serangoon Loop, Suite #402	Singapore	Rleka@gmail.com	555-8787
21	Lyngbysild	Lyngbysild Fiskebakken 10	Denmark	Lyn@gmail.com	43844108
22	Zaanse Snoepfabriek	Verkoop Rijnweg 22	Netherlands	Zaanse Snoepfabriek@gmail.com	(12345) 1212
23	Karkki Oy	Valtakatu 12	Finland	Karkki Oy@gmail.com	(953) 10956
24	G'day, Mate	170 Prince Edward Parade Hunter's Hill	Australia	G@gmail.com	(02) 555-5914
25	Ma Maison	2960 Rue St. Laurent	Canada	MaMaison@gmail.com	(514) 555-9022
26	Pasta Buttini s.r.l.	Via dei Gelsomini, 153	Italy	Pastas.r.l.@gmail.com	(089) 6547665
27	Escargots Nouveaux	22, rue H. Voiron	France	Nouveaux@gmail.com	85.57.00.07
28	Gai pâturage	Bat. B 3, rue des Alpes	France	Gai@gmail.com	38.76.98.06
29	Forêts d'érables	148 rue Chasseur	Canada	Forêts d@gmail.com	(514) 555-2955
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    restore.sql                                                                                         0000600 0004000 0002000 00000027623 14501220317 0015371 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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

DROP DATABASE proyecto_da_db;
--
-- Name: proyecto_da_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE proyecto_da_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_El Salvador.1252';


ALTER DATABASE proyecto_da_db OWNER TO postgres;

\connect proyecto_da_db

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
-- Name: campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns (
    campaign_id integer NOT NULL,
    campaign_type character varying(255),
    campaign_mediatype character varying(255),
    startdate date,
    finishdate date
);


ALTER TABLE public.campaigns OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(255),
    category_description text
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    supplier_id integer,
    category_id integer,
    product_name character varying(255),
    product_price numeric
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255),
    supplier_adress character varying(255),
    supplier_country character varying(255),
    supplier_email character varying(255),
    supplier_phone character varying(255)
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: costo_productos_proveedores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.costo_productos_proveedores AS
 SELECT p.product_name,
    sp.supplier_name,
    p.product_price
   FROM (public.products p
     JOIN public.suppliers sp ON ((p.supplier_id = sp.supplier_id)))
  GROUP BY p.product_name, sp.supplier_name, p.product_price;


ALTER TABLE public.costo_productos_proveedores OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    customer_name character varying(255),
    customer_adress text,
    customer_age integer,
    customer_city character varying(255),
    customer_phone character varying(255),
    customer_email character varying(255),
    customer_gender character varying(255)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    store_id integer,
    employee_name character varying(255),
    employee_gender character varying(255),
    employee_birthdate date,
    employee_phone character varying(255)
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: fact_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_sales (
    sales_id integer NOT NULL,
    customer_id integer,
    employee_id integer,
    shipment_id integer,
    campaign_id integer,
    salesdate date,
    totalsales numeric
);


ALTER TABLE public.fact_sales OWNER TO postgres;

--
-- Name: impactocampana_venta; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.impactocampana_venta AS
 SELECT s.campaign_id,
    sum(s.totalsales) AS total,
    cam.startdate AS fecha_inico_campana,
    cam.finishdate AS fecha_final_campana
   FROM (public.fact_sales s
     JOIN public.campaigns cam ON ((s.campaign_id = cam.campaign_id)))
  WHERE ((s.salesdate >= '2022-01-01'::date) AND (s.salesdate <= '2023-09-11'::date))
  GROUP BY s.campaign_id, cam.startdate, cam.finishdate
  ORDER BY (sum(s.totalsales)) DESC;


ALTER TABLE public.impactocampana_venta OWNER TO postgres;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    product_sold integer,
    product_quantity integer,
    product_available integer
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: salesdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salesdetails (
    salesdetails_id integer NOT NULL,
    sales_id integer,
    product_id integer,
    store_id integer,
    product_quantity integer
);


ALTER TABLE public.salesdetails OWNER TO postgres;

--
-- Name: shipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment (
    shipment_id integer NOT NULL,
    shipper_name character varying(255),
    shipper_phone character varying(255)
);


ALTER TABLE public.shipment OWNER TO postgres;

--
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    store_id integer NOT NULL,
    store_adress character varying(255),
    store_type character varying(255)
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- Name: top10productosmasvendidos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.top10productosmasvendidos AS
 SELECT cu.customer_name,
    sl.customer_id,
    cu.customer_age,
    cu.customer_gender,
    cu.customer_city,
    sum(sl.totalsales) AS ventatotal
   FROM (public.fact_sales sl
     JOIN public.customers cu ON ((sl.customer_id = cu.customer_id)))
  GROUP BY cu.customer_name, sl.customer_id, cu.customer_age, cu.customer_gender, cu.customer_city
  ORDER BY (sum(sl.totalsales)) DESC
 LIMIT 10;


ALTER TABLE public.top10productosmasvendidos OWNER TO postgres;

--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaigns (campaign_id, campaign_type, campaign_mediatype, startdate, finishdate) FROM stdin;
\.
COPY public.campaigns (campaign_id, campaign_type, campaign_mediatype, startdate, finishdate) FROM '$$PATH$$/3391.dat';

--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, category_name, category_description) FROM stdin;
\.
COPY public.category (category_id, category_name, category_description) FROM '$$PATH$$/3392.dat';

--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, customer_name, customer_adress, customer_age, customer_city, customer_phone, customer_email, customer_gender) FROM stdin;
\.
COPY public.customers (customer_id, customer_name, customer_adress, customer_age, customer_city, customer_phone, customer_email, customer_gender) FROM '$$PATH$$/3393.dat';

--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, store_id, employee_name, employee_gender, employee_birthdate, employee_phone) FROM stdin;
\.
COPY public.employees (employee_id, store_id, employee_name, employee_gender, employee_birthdate, employee_phone) FROM '$$PATH$$/3394.dat';

--
-- Data for Name: fact_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_sales (sales_id, customer_id, employee_id, shipment_id, campaign_id, salesdate, totalsales) FROM stdin;
\.
COPY public.fact_sales (sales_id, customer_id, employee_id, shipment_id, campaign_id, salesdate, totalsales) FROM '$$PATH$$/3395.dat';

--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (inventory_id, product_id, product_sold, product_quantity, product_available) FROM stdin;
\.
COPY public.inventory (inventory_id, product_id, product_sold, product_quantity, product_available) FROM '$$PATH$$/3396.dat';

--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, supplier_id, category_id, product_name, product_price) FROM stdin;
\.
COPY public.products (product_id, supplier_id, category_id, product_name, product_price) FROM '$$PATH$$/3397.dat';

--
-- Data for Name: salesdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salesdetails (salesdetails_id, sales_id, product_id, store_id, product_quantity) FROM stdin;
\.
COPY public.salesdetails (salesdetails_id, sales_id, product_id, store_id, product_quantity) FROM '$$PATH$$/3398.dat';

--
-- Data for Name: shipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipment (shipment_id, shipper_name, shipper_phone) FROM stdin;
\.
COPY public.shipment (shipment_id, shipper_name, shipper_phone) FROM '$$PATH$$/3399.dat';

--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (store_id, store_adress, store_type) FROM stdin;
\.
COPY public.stores (store_id, store_adress, store_type) FROM '$$PATH$$/3400.dat';

--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (supplier_id, supplier_name, supplier_adress, supplier_country, supplier_email, supplier_phone) FROM stdin;
\.
COPY public.suppliers (supplier_id, supplier_name, supplier_adress, supplier_country, supplier_email, supplier_phone) FROM '$$PATH$$/3401.dat';

--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: fact_sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sales_id);


--
-- Name: salesdetails salesdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salesdetails
    ADD CONSTRAINT salesdetails_pkey PRIMARY KEY (salesdetails_id);


--
-- Name: shipment shipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             