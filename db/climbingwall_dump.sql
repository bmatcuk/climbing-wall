--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = climbingwall, pg_catalog;

--
-- Data for Name: rooms; Type: TABLE DATA; Schema: climbingwall; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE rooms DISABLE TRIGGER ALL;

COPY rooms (id, name, sort) FROM stdin;
1	Bouldering	1
2	Top Rope	2
\.


ALTER TABLE rooms ENABLE TRIGGER ALL;

--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: climbingwall; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 2, true);


--
-- Data for Name: sections; Type: TABLE DATA; Schema: climbingwall; Owner: postgres
--

ALTER TABLE sections DISABLE TRIGGER ALL;

COPY sections (id, room_id, name, sort) FROM stdin;
1	1	The Block	1
2	1	The Alcove	2
3	1	Cave	3
4	1	The 30/20	4
5	1	Roof Escape	5
6	1	The 45	6
7	1	Slab	7
8	1	Wally McWallface	8
9	1	The Bulge	9
10	1	Vert Walls	10
11	1	The Cliff	11
12	1	Tunnel	12
13	1	Inner Sanctum	13
14	2	Wall 1	1
15	2	Wall 2	2
16	2	Wall 3	3
17	2	Wall 4	4
18	2	Wall 5	5
19	2	Wall 6	6
20	2	Wall 7	7
21	2	Wall 8	8
22	2	Wall 9	9
\.


ALTER TABLE sections ENABLE TRIGGER ALL;

--
-- Data for Name: setters; Type: TABLE DATA; Schema: climbingwall; Owner: postgres
--

ALTER TABLE setters DISABLE TRIGGER ALL;

COPY setters (id, abbr, name) FROM stdin;
1	AM	Alan
2	AL	Adrian
5	DKB	Bill
6	JTS	Jeff
7	OJV	Olivia
8	PW	Paul
11	TAKU	Taku
12	TO	Taku
13	TLS	Taku
14	TS	Trinity
15	TOM	Tomas
16	ZN	Zoe
17	ME	(?)
18	BC	(?)
19	JRP	(?)
3	CD	Chris D
4	CRP	Chris P
9	SAM	Sam S
10	SJ	Sam L(?)
\.


ALTER TABLE setters ENABLE TRIGGER ALL;

--
-- Data for Name: subsections; Type: TABLE DATA; Schema: climbingwall; Owner: postgres
--

ALTER TABLE subsections DISABLE TRIGGER ALL;

COPY subsections (id, section_id, name, sort) FROM stdin;
1	1	Entry Wall	1
2	1	Walls Facing the Bulge	2
3	1	Archway	3
4	1	Facing Wally McWallface	4
5	1	Under Campus Boards	5
6	1	Facing Lobby	6
7	1	Right of Entry Wall	7
8	2	Left	1
9	2	Middle	2
10	2	Right	3
11	3	Entrance Wall Left	1
12	3	Interior Left	2
13	3	Interior Back + Right	3
14	3	Entrance Wall Right	4
15	4	Left	1
16	4	Middle	2
17	4	Right	3
18	5	Left to Right	1
19	6	Left to Right	1
20	7	Left + Arch	1
21	7	Right + Wall	2
22	8	Wall + Tunnel Opening	1
23	9	Kiki (Right)	1
24	9	Bouba (Left)	2
25	10	Right Side + Chimney	1
26	10	Left Side	2
27	10	Back Side	3
28	11	Right Side	1
29	11	Left Side	2
30	12	Mouth	1
31	12	Throat	2
32	13	3pm (Tunnel Mouth)	1
34	13	9pm (Twins)	3
35	13	Midnight	4
36	14	Wall 1	1
37	15	Wall 2	1
38	16	Wall 3	1
39	17	Wall 4	1
40	18	Wall 5	1
41	19	Wall 6	1
42	20	Wall 7	1
43	21	Wall 8	1
44	22	Wall 9	1
33	13	6pm (Angled)	2
\.


ALTER TABLE subsections ENABLE TRIGGER ALL;

--
-- Data for Name: routes; Type: TABLE DATA; Schema: climbingwall; Owner: postgres
--

ALTER TABLE routes DISABLE TRIGGER ALL;

COPY routes (id, subsection_id, difficulty, difficulty_mod, color1, color2, symbol, setter1_id, setter2_id, description, active, set_on, updated_on, sort) FROM stdin;
117	14	5	0	orange	\N	\N	7	\N	Edge Off Black Ledge Off	t	2021-10-05	\N	9
416	16	3	0	blue	\N	\N	7	\N	Sit Start	t	2022-01-12	\N	19
115	14	\N	0	green	\N	sine wave	4	\N	Pop Up! Edge On	t	2021-12-03	\N	5
214	22	0	0	yellow	\N	\N	7	\N	Top Out Low	t	2021-12-13	\N	0
68	9	2	0	pink	\N	\N	7	\N	Sit Start Open Feet	t	2021-11-09	\N	6
72	9	5	0	black	\N	\N	7	\N	\N	t	2021-11-04	\N	11
69	9	3	0	pink	\N	\N	7	\N	\N	t	2021-11-04	\N	10
74	9	\N	0	white	\N	circles	7	\N	Bat Hang Start	t	2021-11-11	\N	4
504	2	\N	0	white	\N	YP	1	\N	Youth Project	t	2022-05-02	\N	2
71	9	4	0	purple	\N	\N	7	\N	\N	t	2021-11-09	\N	7
66	9	1	1	red	\N	\N	7	\N	\N	t	2021-11-04	\N	8
55	8	1	0	white	\N	\N	7	\N	Open Feet Edge Off	t	2021-11-19	\N	0
65	9	1	0	yellow	\N	\N	7	\N	\N	t	2021-11-04	\N	2
73	9	5	1	white	\N	\N	12	\N	Bat Hang Start	t	2021-11-04	\N	1
49	7	3	0	blue	\N	\N	7	\N	\N	f	2021-08-19	\N	0
51	7	4	0	yellow	\N	\N	7	\N	\N	f	2021-08-19	\N	1
199	20	\N	0	orange	\N	\N	7	\N	Compression Project	t	2021-11-30	\N	0
67	9	2	0	green	\N	dashes	14	\N	\N	t	2021-11-11	\N	3
186	20	1	0	white	\N	squares	7	\N	Traverse	t	2021-12-09	\N	7
46	7	1	1	red	\N	\N	7	\N	\N	f	2021-08-19	\N	7
47	7	2	0	black	\N	\N	7	\N	\N	f	2021-08-17	\N	3
56	8	2	-1	red	\N	\N	7	\N	\N	t	2021-11-09	\N	3
57	8	2	0	yellow	\N	sine wave	7	\N	Sit Start	t	2021-11-09	\N	5
211	21	4	0	red	\N	dots	15	\N	Ladybug	t	2021-12-09	\N	0
120	15	1	0	white	\N	\N	5	\N	Features Off	t	2022-01-18	\N	7
123	15	2	1	purple	\N	\N	5	\N	\N	t	2022-01-13	\N	8
85	10	\N	0	red	\N	\N	7	\N	Project Sit Start Edge Off	t	2021-11-09	\N	9
116	14	4	0	purple	\N	\N	7	\N	Traverse	t	2021-10-05	\N	6
118	14	5	1	green	\N	\N	7	\N	\N	t	2021-10-05	\N	4
112	14	1	0	pink	\N	\N	7	\N	\N	t	2021-10-05	\N	1
84	10	\N	0	white	\N	\N	7	\N	Dyno Practice	t	2021-11-11	\N	8
111	14	-1	0	red	\N	\N	1	\N	\N	t	2021-09-30	\N	7
511	4	1	0	purple	\N	\N	7	\N	\N	t	2022-05-03	\N	0
78	10	1	0	blue	\N	\N	7	\N	Edge Off	t	2021-11-04	\N	7
80	10	3	0	green	\N	\N	7	\N	\N	t	2021-11-04	\N	6
464	34	1	0	black	\N	\N	5	\N	\N	t	2022-04-12	\N	4
5	1	2	1	white	\N	\N	7	\N	Traverse	f	2021-08-18	\N	6
469	35	2	1	pink	\N	\N	7	\N	\N	t	2022-04-12	\N	4
460	33	6	0	black	\N	\N	5	\N	No Stem	t	2022-04-12	\N	7
82	10	5	-1	blue	\N	\N	7	\N	Middle Volume Off	t	2021-11-09	\N	4
81	10	4	1	green	\N	sine wave	7	\N	Edge Off Volume Off	t	2021-11-11	\N	3
13	2	3	-1	green	\N	\N	7	\N	\N	f	2021-09-02	\N	1
9	2	1	0	red	\N	\N	7	\N	Traverse	f	2021-08-31	\N	0
95	12	1	1	blue	\N	\N	7	\N	\N	t	2021-10-07	\N	7
14	2	3	1	pink	\N	\N	7	\N	Edge Off	f	2021-08-31	\N	3
10	2	1	0	green	\N	\N	7	\N	Sit Start	f	2021-09-02	\N	8
23	3	3	0	white	\N	circles	17	\N	Open Feet	f	2021-11-10	\N	1
124	15	2	1	red	\N	\N	5	\N	Heel Start	t	2022-01-18	\N	1
21	3	2	1	black	\N	\N	7	\N	\N	f	2021-09-02	\N	5
22	3	3	0	red	\N	\N	7	\N	\N	f	2021-09-02	\N	2
25	3	5	1	orange	\N	circles	7	\N	Dyno Stem Off	f	2021-08-19	\N	6
125	15	2	1	blue	\N	\N	7	\N	\N	t	2022-01-15	\N	2
26	3	\N	0	pink	\N	\N	7	\N	Dyno Stem Off	f	2021-09-02	\N	4
20	3	\N	0	white	\N	YP	1	\N	Youth Program	f	2021-09-28	\N	3
28	4	1	1	blue	\N	\N	7	\N	Right	f	2021-09-02	\N	7
33	4	3	0	green	\N	\N	7	\N	\N	f	2021-09-02	\N	0
34	4	3	0	pink	\N	\N	7	\N	Sit Start	f	2021-09-02	\N	2
36	4	4	1	red	\N	\N	7	\N	Sit Start	f	2021-08-31	\N	3
37	4	5	0	yellow	\N	\N	7	\N	\N	f	2021-09-02	\N	4
39	6	1	0	blue	\N	\N	7	\N	\N	f	2021-08-07	\N	5
491	6	3	1	blue	\N	\N	5	\N	\N	t	2021-04-28	\N	3
490	6	5	0	black	\N	\N	7	\N	\N	t	2021-04-28	\N	0
500	7	2	1	pink	\N	\N	7	\N	No Edge	t	2021-04-28	\N	6
122	15	2	0	\N	\N	\N	7	\N	Features Off	f	\N	\N	10
516	1	4	0	white	\N	\N	7	\N	Edges Off	t	2022-05-05	\N	1
121	15	1	0	blue	\N	\N	7	\N	\N	t	2022-01-18	\N	9
60	8	4	0	purple	\N	\N	7	\N	Purple	t	2021-11-09	\N	10
79	10	2	1	purple	\N	\N	7	\N	Edge Off	t	2021-11-09	\N	2
61	8	4	0	pink	\N	\N	7	\N	Pink	t	2021-11-09	\N	7
63	8	5	1	blue	\N	\N	7	\N	Edge Off	t	2021-11-03	\N	2
86	10	\N	0	white	\N	sine wave	4	\N	Pop Up!	t	2021-12-10	\N	1
87	11	0	0	red	\N	\N	1	\N	\N	t	2021-09-30	\N	4
88	11	1	0	orange	\N	\N	7	\N	\N	t	2021-10-05	\N	0
96	12	3	0	red	\N	\N	7	\N	\N	t	2021-10-07	\N	9
89	11	2	0	green	\N	\N	7	\N	\N	t	2021-10-05	\N	1
90	11	4	0	purple	\N	\N	7	\N	Traverse	t	2021-12-05	\N	3
91	11	5	0	white	\N	\N	7	\N	\N	t	2021-10-05	\N	2
99	12	6	0	black	\N	\N	7	\N	\N	t	2021-09-30	\N	6
97	12	3	0	green	\N	\N	7	\N	Traverse	t	2021-09-30	\N	5
92	12	1	0	\N	\N	\N	7	\N	\N	f	\N	\N	10
110	13	\N	0	pink	\N	\N	4	\N	Pop Up!	t	2021-12-03	\N	6
105	13	3	0	orange	\N	\N	7	\N	Open Feet	t	2021-10-07	\N	5
93	12	1	0	orange	\N	\N	7	\N	Traverse	t	2021-09-30	\N	4
102	12	\N	0	yellow	\N	\N	7	\N	Around the World Open Feet	t	2021-10-07	\N	3
101	12	\N	0	white	\N	sine wave	7	\N	Dyno	t	2021-10-07	\N	2
94	12	1	1	blue	\N	\N	7	\N	\N	t	2021-10-05	\N	1
103	13	0	0	green	\N	\N	1	\N	\N	t	2021-10-07	\N	7
109	13	\N	0	blue	\N	\N	1	\N	\N	t	2021-09-30	\N	4
104	13	1	0	black	\N	\N	7	\N	\N	t	2021-09-30	\N	3
108	13	4	1	red	\N	\N	7	\N	\N	t	2021-09-30	\N	2
106	13	3	0	green	\N	\N	7	\N	Traverse	t	2021-09-30	\N	1
135	16	2	0	blue	\N	\N	5	\N	\N	t	2022-01-15	\N	5
134	16	1	1	green	\N	\N	7	\N	Open Feet	t	2022-01-18	\N	9
132	16	0	0	green	\N	\N	7	\N	\N	t	2022-01-10	\N	0
131	16	-1	0	red	\N	\N	7	\N	\N	t	2022-01-10	\N	16
133	16	1	0	white	\N	\N	5	\N	\N	t	2022-01-18	\N	17
151	17	2	0	purple	\N	\N	5	\N	Edge Off	t	2022-01-18	\N	6
152	17	3	-1	pink	\N	\N	7	\N	\N	t	2022-01-18	\N	5
218	22	2	-1	blue	\N	\N	1	\N	\N	t	2021-12-30	\N	15
198	20	\N	0	\N	\N	\N	7	\N	\N	f	\N	\N	15
206	21	3	1	blue	\N	\N	1	\N	\N	t	2021-12-02	\N	12
217	22	1	1	green	\N	\N	7	\N	To Low	t	2021-12-23	\N	8
201	21	1	1	pink	\N	triangles	14	\N	\N	t	2021-12-09	\N	10
207	21	3	1	purple	\N	\N	7	\N	Volume Off	t	2021-12-07	\N	11
210	21	4	0	white	\N	\N	7	\N	Left Volume Edge Off	t	2021-11-30	\N	9
208	21	4	-1	orange	\N	\N	7	\N	Right Wall Off	t	2021-11-30	\N	8
205	21	3	0	black	\N	\N	7	\N	Features On	t	2021-12-02	\N	7
212	21	5	0	black	\N	\N	7	\N	Features Off	t	2021-12-02	\N	6
204	21	2	1	red	\N	\N	7	\N	Sit Start	t	2021-11-30	\N	3
213	22	-1	0	red	\N	\N	7	\N	\N	t	2021-12-23	\N	16
202	21	2	0	purple	\N	x's	1	\N	\N	t	2021-12-06	\N	2
209	21	4	0	yellow	\N	\N	7	\N	Yellow Edge Off	t	2021-12-02	\N	1
192	20	3	0	black	\N	\N	1	\N	\N	t	2021-12-06	\N	11
203	21	2	0	pink	\N	\N	7	\N	\N	t	2021-12-02	\N	13
232	23	1	1	yellow	\N	x's	7	\N	Traverse	t	2022-02-10	\N	12
419	22	3	-1	green	\N	\N	7	\N	\N	t	2021-12-23	\N	9
216	22	1	1	white	\N	\N	7	\N	\N	t	2021-12-27	\N	7
222	22	3	1	purple	\N	\N	7	\N	Dyno Top Out Low	t	2021-12-23	\N	6
220	22	2	0	red	\N	\N	7	\N	Top Out Low	t	2021-12-23	\N	4
461	33	\N	0	pink	\N	\N	5	\N	\N	f	2022-04-05	\N	9
215	22	1	0	blue	\N	\N	7	\N	\N	t	2021-12-30	\N	3
262	26	2	1	orange	\N	\N	7	\N	Right	t	2021-09-16	\N	4
280	27	6	-1	pink	\N	\N	7	\N	Jump	t	2021-09-16	\N	7
296	29	3	0	orange	\N	\N	7	\N	Cave Start	t	2021-07-15	\N	13
483	2	5	0	black	\N	\N	7	\N	Edges Off, Black Volume Off	t	2021-04-28	\N	8
188	20	1	0	green	\N	\N	7	\N	\N	t	2021-12-02	\N	13
189	20	1	1	pink	\N	\N	7	\N	\N	t	2021-12-02	\N	14
465	34	3	0	orange	\N	\N	7	\N	\N	t	2022-04-12	\N	7
493	6	3	0	orange	\N	\N	5	\N	\N	t	2021-04-28	\N	5
470	35	0	0	blue	\N	\N	7	\N	\N	t	2022-04-12	\N	8
193	20	3	1	blue	\N	\N	1	\N	\N	t	2021-12-02	\N	12
196	20	5	1	yellow	\N	sine wave	7	\N	\N	t	2021-12-07	\N	10
191	20	2	0	orange	\N	squiggles	7	\N	\N	t	\N	\N	8
473	33	5	0	white	\N	stars	7	\N	Stem Off	t	2022-04-14	\N	10
450	35	4	0	red	\N	\N	5	\N	\N	t	2022-04-07	\N	13
247	24	3	1	green	\N	\N	5	\N	\N	t	2022-02-01	\N	3
243	24	2	0	green	\N	sine wave	7	\N	Open Feet	t	2022-02-08	\N	7
229	23	0	0	blue	\N	\N	7	\N	\N	t	2022-02-01	\N	9
231	23	1	1	green	\N	squares	7	\N	Open Feet	t	2022-02-10	\N	10
233	23	2	-1	pink	\N	hearts	7	\N	\N	t	2022-02-10	\N	7
219	22	2	-1	black	\N	\N	7	\N	Dyno	t	\N	\N	2
194	20	4	1	yellow	\N	\N	7	\N	\N	t	2021-11-30	\N	9
195	20	5	-1	green	\N	double line	7	\N	Stem Off	t	\N	\N	4
185	20	0	0	red	\N	\N	7	\N	\N	t	2021-11-30	\N	5
187	20	1	0	purple	\N	\N	7	\N	\N	t	2021-12-07	\N	3
480	2	4	-1	red	\N	\N	7	\N	\N	t	2021-04-28	\N	1
501	1	1	0	black	\N	\N	7	\N	Open Feet	t	2022-05-03	\N	0
492	6	3	1	yellow	\N	\N	5	\N	No Edge	t	2021-04-26	\N	4
487	3	3	0	black	\N	\N	7	\N	Edges Off, Stem Off	t	2021-04-28	\N	3
477	1	2	1	red	\N	\N	5	\N	\N	t	2021-04-26	\N	4
150	17	1	1	red	\N	\N	7	\N	\N	t	2022-01-12	\N	7
156	17	\N	0	yellow	\N	squiggles	7	\N	Project Dyno	t	2022-01-18	\N	4
155	17	6	0	white	\N	\N	7	\N	\N	t	2022-01-18	\N	3
163	18	2	0	red	\N	\N	7	\N	\N	t	2022-03-08	\N	7
250	25	1	1	yellow	\N	x's	7	\N	Traverse	t	2022-02-10	\N	6
164	18	4	0	black	\N	\N	7	\N	Black	t	2022-03-03	\N	8
154	17	5	-1	orange	\N	\N	7	\N	Sit Start	t	2022-01-18	\N	2
234	23	3	1	white	\N	\N	5	\N	\N	t	2022-02-03	\N	6
165	18	2	1	pink	\N	\N	16	\N	\N	t	2022-03-01	\N	9
157	17	\N	0	orange	\N	line	5	\N	No Edge	t	2022-01-11	\N	1
153	17	4	-1	green	\N	\N	5	\N	\N	t	2022-01-18	\N	0
166	18	4	0	purple	\N	\N	5	\N	\N	t	2022-03-01	\N	10
159	18	4	-1	purple	\N	\N	7	\N	Purple	t	2022-03-08	\N	2
167	18	4	0	red	\N	\N	7	\N	Red	t	2022-03-01	\N	11
168	18	2	0	green	\N	\N	6	\N	\N	t	2022-03-08	\N	12
169	18	3	1	yellow	\N	\N	5	\N	\N	t	2022-03-03	\N	13
170	18	\N	0	green	\N	squares	7	\N	Green	t	2022-03-10	\N	14
160	18	4	0	yellow	\N	\N	7	\N	Yellow	t	2022-03-03	\N	3
161	18	2	0	orange	\N	\N	5	\N	\N	t	2022-03-01	\N	4
162	18	1	0	green	\N	\N	5	\N	\N	t	2022-03-10	\N	5
235	23	3	1	orange	\N	\N	5	\N	\N	t	2022-02-03	\N	0
239	23	6	-1	red	\N	\N	7	\N	Features Off	t	2022-02-03	\N	5
236	23	4	0	red	\N	\N	7	\N	\N	t	2022-02-03	\N	4
230	23	1	0	yellow	\N	\N	7	\N	\N	t	2022-02-08	\N	3
238	23	5	0	pink	\N	\N	7	\N	Features Off	t	2022-02-03	\N	2
241	23	\N	0	black	\N	\N	7	\N	Features Off	t	2022-02-07	\N	1
248	24	4	0	blue	\N	\N	5	\N	Sit Start	t	2022-02-03	\N	6
249	24	4	1	orange	\N	circles	7	\N	Sit Start	t	2022-02-10	\N	5
246	24	3	0	purple	\N	\N	7	\N	\N	t	2022-02-03	\N	4
244	24	2	0	yellow	\N	\N	7	\N	\N	t	2022-02-08	\N	2
245	24	2	1	pink	\N	\N	5	\N	Green Volume Only	t	2022-02-01	\N	1
242	24	1	-1	red	\N	\N	7	\N	\N	t	2022-02-01	\N	0
252	25	4	0	yellow	\N	\N	7	\N	Edges Off	t	2022-02-10	\N	4
251	25	2	0	red	\N	\N	7	\N	\N	t	2022-02-03	\N	1
258	26	1	-1	orange	\N	\N	1	\N	Left	t	2021-09-14	\N	3
292	29	2	1	blue	\N	\N	7	\N	Cave Start Top Out	t	2021-07-13	\N	11
295	29	3	0	yellow	\N	\N	7	\N	\N	t	2021-07-15	\N	7
288	29	1	1	green	\N	\N	7	\N	No Top Out	t	2021-07-13	\N	3
289	29	2	0	orange	\N	\N	7	\N	Stand Start	t	2021-07-15	\N	4
260	26	2	0	white	\N	\N	7	\N	Open Feet	t	2021-09-16	\N	2
290	29	2	1	purple	\N	\N	7	\N	\N	t	2021-07-15	\N	6
257	26	0	0	red	\N	\N	7	\N	Missing tag - under volume	t	\N	\N	8
423	42	3	0	\N	\N	\N	7	\N	404 UNKNOWN	t	2022-04-01	\N	1
481	2	4	0	green	\N	\N	7	\N	\N	t	2021-04-28	\N	5
442	34	4	-1	yellow	\N	\N	7	\N	Sit Start	t	2022-04-07	\N	14
294	29	3	0	yellow	\N	\N	7	\N	Open Feet	t	2021-07-15	\N	1
293	29	2	1	green	\N	\N	7	\N	Cave Start No Top Out	t	2021-07-10	\N	10
441	34	4	0	purple	\N	\N	5	\N	No Stem	t	2022-04-05	\N	11
305	30	3	-1	orange	\N	\N	7	\N	\N	t	2021-12-28	\N	1
303	30	2	0	purple	\N	\N	7	\N	\N	t	2021-12-23	\N	5
307	30	6	0	white	\N	\N	7	\N	No stem, roof only	t	2021-12-30	\N	3
304	30	2	1	green	\N	\N	7	\N	\N	t	2021-12-30	\N	2
308	30	\N	0	pink	\N	\N	7	\N	Timed Race	t	2021-12-28	\N	4
306	30	4	0	blue	\N	\N	7	\N	\N	t	2021-12-30	\N	0
311	31	6	1	black	\N	\N	7	\N	Tunnel Features Off	t	2021-12-20	\N	4
466	34	\N	0	orange	\N	\N	5	\N	No Stem	t	2022-04-12	\N	13
462	34	0	0	orange	\N	\N	7	\N	Open Feet	t	2022-04-12	\N	2
474	34	5	0	white	\N	\N	7	\N	\N	t	2022-04-14	\N	10
471	35	3	0	orange	\N	\N	7	\N	\N	t	2022-04-12	\N	10
449	35	4	-1	green	\N	\N	7	\N	Right	t	2022-04-07	\N	12
6	1	\N	0	yellow	\N	sine wave	4	\N	Pop Up! Sit start	f	2021-12-06	\N	2
2	1	-1	0	black	\N	\N	7	\N	\N	f	2021-08-17	\N	4
3	1	1	0	blue	\N	\N	7	\N	Sit Start	f	2021-08-17	\N	5
412	1	4	1	pink	\N	\N	1	\N	\N	f	2021-08-19	\N	0
4	1	2	0	green	\N	\N	7	\N	\N	f	2021-08-17	\N	3
356	36	2	0	\N	\N	\N	7	\N	Black Cat's Steps	t	\N	\N	1
357	36	1	0	\N	\N	\N	7	\N	Spooky Scary Spooky So Spooky Scary	t	\N	\N	2
358	36	2	0	\N	\N	\N	7	\N	2 Finger Spells	t	\N	\N	3
359	36	3	0	\N	\N	\N	7	\N	Witch's Magic Crimps	t	\N	\N	4
360	37	2	0	\N	\N	\N	7	\N	Think Happy Thoughts	t	\N	\N	1
361	37	1	0	\N	\N	\N	7	\N	Magic Beans	t	\N	\N	2
362	37	3	0	\N	\N	\N	7	\N	Trail of Bread Crumbs	t	\N	\N	3
363	37	1	0	\N	\N	\N	1	\N	Vitamin C	t	\N	\N	4
364	37	3	0	\N	\N	\N	1	\N	ProBiotics	t	\N	\N	5
365	37	2	0	\N	\N	\N	7	\N	Rub Some Dirt on It	t	\N	\N	6
366	37	1	0	\N	\N	\N	7	\N	Hydrate or Die-drate	t	\N	\N	7
367	38	3	0	\N	\N	\N	7	\N	Slap on the Back	t	\N	\N	1
368	38	3	0	\N	\N	\N	7	\N	Minimum Holds	t	\N	\N	2
369	38	2	0	\N	\N	\N	7	\N	Backbone	t	\N	\N	3
370	38	1	0	\N	\N	\N	7	\N	Learning Lead	t	\N	\N	4
371	38	2	0	\N	\N	\N	7	\N	Digging My Own Grave	t	\N	\N	5
372	39	1	0	\N	\N	\N	7	\N	Frog and Toad Are Married	t	\N	\N	1
373	39	2	0	\N	\N	\N	7	\N	These Are Not The Holds You Are Looking For	t	\N	\N	2
374	39	3	0	\N	\N	\N	7	\N	I'm A Real Climb	t	\N	\N	3
375	39	3	0	\N	\N	\N	2	\N	Video Game Landfill	t	\N	\N	4
376	39	1	0	\N	\N	\N	9	\N	Fulfilling Dreams	t	\N	\N	5
279	27	5	0	white	\N	\N	7	\N	Edge Off	t	2021-09-16	\N	6
425	42	1	0	\N	\N	\N	7	\N	It's Never Easy	t	2022-04-01	\N	3
309	31	3	-1	pink	\N	\N	7	\N	Missing tag	t	\N	\N	0
273	27	2	0	orange	\N	circles	1	\N	\N	t	2021-09-16	\N	8
427	42	2	0	\N	\N	\N	7	\N	Practice for NY Rock-Friend	t	2022-04-01	\N	5
259	26	1	1	green	\N	\N	7	\N	Edge Off	t	2021-09-14	\N	1
274	27	3	0	yellow	\N	\N	7	\N	\N	t	2021-09-16	\N	10
178	19	4	0	orange	\N	\N	7	\N	\N	t	2022-03-03	\N	7
312	31	\N	0	pink	\N	horz lines	11	\N	Low Top Out	t	2021-12-30	\N	2
310	31	7	0	yellow	\N	\N	7	\N	\N	t	2021-12-23	\N	3
313	31	\N	0	white	\N	sine wave	11	\N	High Top Out	t	2021-12-30	\N	1
177	19	4	1	purple	\N	\N	5	\N	\N	t	2022-03-03	\N	5
314	32	1	1	\N	\N	\N	5	\N	\N	f	\N	\N	1
319	33	0	0	\N	\N	\N	7	\N	\N	f	\N	\N	1
320	33	2	0	\N	\N	\N	1	\N	\N	f	\N	\N	2
321	33	2	0	\N	\N	\N	7	\N	\N	f	\N	\N	3
322	33	2	1	\N	\N	\N	7	\N	Traverse	f	\N	\N	4
323	33	3	0	\N	\N	\N	7	\N	Sit Start	f	\N	\N	5
271	27	1	0	yellow	\N	\N	7	\N	\N	t	2021-09-16	\N	4
283	28	1	0	orange	\N	\N	7	\N	Open Feet	t	2021-07-15	\N	4
328	34	1	-1	\N	\N	\N	7	\N	\N	f	\N	\N	1
329	34	2	-1	\N	\N	\N	7	\N	Sit Start	f	\N	\N	2
330	34	3	0	\N	\N	\N	7	\N	Sit Start	f	\N	\N	3
331	34	3	1	\N	\N	\N	3	\N	Open Feet	f	\N	\N	4
332	34	4	0	\N	\N	\N	7	\N	\N	f	\N	\N	5
333	34	5	0	\N	\N	\N	7	\N	\N	f	\N	\N	6
276	27	3	1	blue	\N	\N	1	\N	\N	t	2021-09-16	\N	3
272	27	1	0	green	\N	\N	7	\N	\N	t	2021-09-14	\N	2
282	28	1	0	green	\N	\N	7	\N	\N	t	2021-07-15	\N	5
334	34	5	1	\N	\N	\N	5	\N	\N	f	\N	\N	7
278	27	4	0	black	\N	\N	7	\N	\N	t	2021-09-14	\N	1
270	27	1	0	red	\N	\N	7	\N	\N	t	2021-09-16	\N	5
335	34	5	1	\N	\N	\N	7	\N	Stem Off	f	\N	\N	8
336	34	6	0	\N	\N	\N	7	\N	Volume Off	f	\N	\N	9
338	35	\N	0	\N	\N	\N	1	\N	Youth Program	f	\N	\N	1
339	35	-1	0	\N	\N	\N	7	\N	\N	f	\N	\N	2
340	35	1	0	\N	\N	\N	7	\N	\N	f	\N	\N	3
341	35	1	0	\N	\N	\N	7	\N	Elimination	f	\N	\N	4
342	35	2	0	\N	\N	\N	3	\N	Purple	f	\N	\N	5
284	28	2	0	pink	\N	\N	7	\N	\N	t	2021-07-15	\N	3
343	35	2	0	\N	\N	\N	3	\N	Yellow	f	\N	\N	6
285	28	3	0	purple	\N	\N	7	\N	\N	t	2021-07-15	\N	2
286	28	\N	0	pink	\N	\N	1	\N	Pop Up!	t	2021-11-25	\N	0
281	28	1	-1	red	\N	\N	7	\N	\N	t	2021-07-15	\N	1
344	35	2	0	\N	\N	\N	5	\N	Edge Off	f	\N	\N	7
345	35	2	0	\N	\N	\N	7	\N	Elimination	f	\N	\N	8
346	35	2	1	\N	\N	\N	7	\N	\N	f	\N	\N	9
347	35	3	-1	\N	\N	\N	3	\N	\N	f	\N	\N	10
377	39	2	0	\N	\N	\N	9	\N	A Bowtie That Can't Be Undone	t	\N	\N	6
378	39	3	0	\N	\N	\N	9	\N	No Pressure... But It Gets Worse	t	\N	\N	7
379	40	2	0	\N	\N	\N	7	\N	Captain Hold	t	\N	\N	1
380	40	1	0	\N	\N	\N	7	\N	Yellow	t	\N	\N	2
381	40	3	0	\N	\N	\N	7	\N	Tension Plank	t	\N	\N	3
382	40	1	0	\N	\N	\N	1	\N	Fun Pix	t	\N	\N	4
383	40	3	0	\N	\N	\N	7	\N	I Can Go The Distance	t	\N	\N	5
384	40	1	0	\N	\N	\N	7	\N	Where I Belong	t	\N	\N	6
385	40	3	0	\N	\N	\N	1	\N	Sweet Baby Gherkins	t	\N	\N	7
386	40	2	0	\N	\N	\N	7	\N	Phil	t	\N	\N	8
387	41	1	0	\N	\N	\N	7	\N	Loose Morals	t	\N	\N	1
388	41	2	0	\N	\N	\N	7	\N	Loose Line	t	\N	\N	2
389	41	3	0	\N	\N	\N	7	\N	Loose Leaf Tea	t	\N	\N	3
390	41	2	0	\N	\N	\N	1	\N	Cat Food	t	\N	\N	4
391	41	2	0	\N	\N	\N	1	\N	Windshield Wiper	t	\N	\N	5
392	41	3	0	\N	\N	\N	7	\N	May Showers Bring Bad Conditions	t	\N	\N	6
393	41	2	0	\N	\N	\N	7	\N	She	t	\N	\N	7
394	41	1	0	\N	\N	\N	7	\N	Matches In May	t	\N	\N	8
1	1	\N	0	white	\N	YP	1	\N	Youth Program	f	2021-08-22	\N	1
437	34	5	0	green	\N	\N	5	\N	\N	t	2022-04-07	\N	6
17	2	4	1	orange	\N	\N	7	\N	Edge Off	f	2021-08-31	\N	2
18	2	\N	0	orange	\N	\N	7	\N	Project - Edges Off	f	2021-08-31	\N	11
19	2	\N	0	yellow	\N	sine wave	4	\N	Pop Up!	f	2021-12-06	\N	12
402	43	2	0	\N	\N	\N	8	\N	Smooth	t	\N	\N	1
403	43	2	0	\N	\N	\N	8	\N	Insult and Injury	t	\N	\N	2
404	43	3	0	\N	\N	\N	8	\N	Mixed Emotions (Dry Ice)	t	\N	\N	3
405	43	3	0	\N	\N	\N	8	\N	Cold As Ice	t	\N	\N	4
406	44	2	0	\N	\N	\N	7	\N	Broken Glass	t	\N	\N	1
407	44	1	0	\N	\N	\N	7	\N	Pass It On	t	\N	\N	2
408	44	3	0	\N	\N	\N	1	\N	Stay Or Go	t	\N	\N	3
409	44	3	0	\N	\N	\N	7	\N	Mantle Like A Manatee	t	\N	\N	4
50	7	3	0	orange	\N	\N	7	\N	Dyno Edge Off	f	2021-08-17	\N	4
52	7	5	0	pink	\N	\N	7	\N	Stem Off	f	2021-08-19	\N	2
24	3	4	-1	green	\N	\N	7	\N	\N	f	2021-09-02	\N	0
413	7	3	1	purple	\N	\N	7	\N	\N	f	2021-08-19	\N	5
48	7	2	1	white	\N	\N	7	\N	Traverse	f	2021-08-19	\N	6
35	4	3	1	black	\N	\N	7	\N	\N	f	2021-09-02	\N	1
130	15	\N	0	pink	blue	\N	5	\N	Traverse	t	2021-01-27	\N	4
70	9	3	1	yellow	\N	sine wave	7	\N	Volumes Off	t	2021-11-11	\N	0
76	9	\N	0	yellow	\N	circles	18	4	Pop Up!	t	2021-12-03	\N	5
75	9	\N	0	green	orange	\N	10	\N	Pop Up!	t	2021-12-22	\N	9
139	16	3	1	orange	\N	\N	5	\N	\N	t	2022-01-12	\N	14
98	12	4	-1	pink	\N	\N	7	\N	\N	t	2021-09-30	\N	0
100	12	6	0	black	\N	\N	7	\N	Edge/Stem Off	t	2021-09-30	\N	8
41	5	3	0	yellow	\N	\N	1	\N	Sit Start	f	2021-08-19	\N	8
506	2	0	0	blue	\N	\N	16	\N	\N	t	2022-05-03	\N	4
83	10	6	-1	yellow	\N	\N	7	\N	Black Volumes Off	t	2021-11-04	\N	0
77	10	-1	0	black	\N	\N	7	\N	\N	t	\N	\N	5
107	13	3	1	pink	\N	\N	7	\N	Sit Start (Broken)	t	2021-10-07	\N	0
137	16	3	0	black	\N	\N	7	\N	\N	t	2022-01-12	\N	13
512	4	\N	0	white	\N	YP	1	\N	\N	t	2022-05-02	\N	4
136	16	2	1	purple	\N	\N	5	\N	\N	t	2022-01-18	\N	10
140	16	4	0	blue	\N	\N	7	\N	\N	t	2022-01-12	\N	12
143	16	4	1	orange	\N	circles	7	\N	Orange	t	2022-01-20	\N	6
45	5	\N	0	orange	\N	\N	4	\N	Pop Up!	f	2021-12-13	\N	9
410	6	6	0	purple	\N	\N	7	\N	Edges Off	f	2021-08-19	\N	7
114	14	2	0	yellow	\N	\N	1	\N	\N	t	2021-09-30	\N	8
113	14	2	-1	black	\N	\N	7	\N	\N	t	2021-10-05	\N	2
119	14	\N	0	white	\N	\N	4	\N	Pop Up!	t	2021-12-13	\N	0
415	14	2	1	white	\N	\N	7	\N	Sit Start - Missing Start Tag	t	\N	\N	3
141	16	4	-1	green	\N	squiggles	7	\N	\N	t	2022-01-20	\N	3
142	16	4	1	black	\N	\N	7	\N	\N	t	2022-01-12	\N	4
54	8	0	1	red	\N	\N	1	\N	\N	t	2021-11-04	\N	11
40	6	2	0	red	\N	\N	7	\N	\N	f	2021-08-09	\N	0
42	6	4	1	pink	\N	\N	7	\N	\N	f	2021-08-19	\N	6
138	16	3	1	yellow	\N	\N	7	\N	\N	t	2022-01-10	\N	18
411	6	2	0	green	\N	x's	1	\N	\N	f	2021-08-19	\N	1
38	6	\N	0	white	\N	YP	1	\N	Youth Program Open Feet	f	2022-01-10	\N	2
44	6	5	-1	orange	\N	\N	7	\N	Edge Off	f	2021-08-19	\N	3
43	6	4	1	green	\N	\N	7	\N	Shhhh...	f	2021-08-19	\N	4
513	4	2	1	pink	\N	\N	16	\N	\N	t	2022-05-03	\N	5
494	6	4	1	green	\N	\N	11	\N	\N	t	2021-04-28	\N	6
126	15	3	0	orange	\N	\N	5	\N	\N	t	2022-01-03	\N	3
128	15	5	0	yellow	\N	\N	7	\N	\N	t	2022-01-13	\N	0
478	1	2	1	purple	\N	\N	5	\N	\N	t	2021-04-28	\N	6
158	18	1	1	white	\N	\N	7	\N	Traverse	t	2022-03-02	\N	0
417	18	\N	0	white	\N	triangles	7	\N	Open Feet	t	2022-03-22	\N	1
129	15	6	0	black	\N	\N	5	\N	Features Off	t	2022-01-18	\N	5
127	15	3	1	pink	\N	\N	5	\N	Flake Off	t	2022-01-13	\N	6
64	8	\N	0	white	\N	sine wave	7	\N	Dyno Practice	t	2021-11-11	\N	9
59	8	3	1	orange	\N	triangles	7	\N	Open feet	t	2021-11-11	\N	12
58	8	3	0	green	\N	\N	7	\N	\N	t	2021-11-04	\N	4
62	8	5	0	black	\N	\N	7	\N	Edge Off	t	2021-11-09	\N	1
414	8	\N	0	blue	green	\N	7	\N	Edges of the Earth Traverses	t	2022-03-24	\N	6
53	8	0	0	orange	\N	\N	1	\N	\N	t	2021-11-04	\N	8
395	42	3	0	\N	\N	\N	1	\N	Bye	f	\N	\N	1
396	42	1	0	\N	\N	\N	1	\N	Good	f	\N	\N	2
397	42	2	0	\N	\N	\N	7	\N	:(	f	\N	\N	3
401	42	2	0	\N	\N	\N	7	\N	The Lines	f	\N	\N	7
172	19	3	0	blue	\N	\N	5	\N	\N	t	2022-03-03	\N	1
173	19	1	1	green	\N	\N	5	\N	\N	t	2022-03-11	\N	2
174	19	5	1	yellow	\N	\N	7	\N	Open Feet	t	2022-03-10	\N	3
175	19	5	0	black	\N	\N	7	\N	Black	t	2022-03-03	\N	6
176	19	3	1	red	\N	\N	7	\N	Dyno	t	2022-03-08	\N	4
315	32	3	1	\N	\N	\N	1	\N	\N	f	\N	\N	2
316	32	4	-1	\N	\N	\N	7	\N	\N	f	\N	\N	3
317	32	4	0	\N	\N	\N	7	\N	\N	f	\N	\N	4
318	32	\N	0	\N	\N	\N	7	\N	\N	f	\N	\N	5
337	34	\N	0	\N	\N	\N	7	\N	Project	f	\N	\N	10
148	16	6	1	red	\N	\N	7	\N	Stem Off	t	2022-01-12	\N	1
146	16	6	0	white	\N	\N	5	\N	\N	t	2022-01-15	\N	2
147	16	6	0	yellow	\N	\N	5	\N	Volume On	t	2022-01-11	\N	7
200	21	-1	0	green	\N	\N	7	\N	\N	t	2021-11-30	\N	4
145	16	4	1	white	\N	smiley	11	\N	Tracking	t	2022-01-18	\N	8
144	16	4	1	pink	\N	\N	5	\N	\N	t	2022-01-12	\N	11
149	16	\N	0	yellow	\N	x's	11	\N	Volumes Off	t	\N	\N	15
421	21	1	0	white	\N	squares	7	\N	\N	t	2021-12-09	\N	5
266	26	4	0	pink	\N	\N	7	\N	Missing tag - under volume	t	\N	\N	9
240	23	6	0	purple	\N	\N	7	\N	\N	t	2022-02-03	\N	8
237	23	5	0	orange	\N	horz lines	7	\N	\N	t	2022-02-10	\N	11
422	19	\N	0	orange	\N	circles	7	\N	Open Feet	t	2021-03-22	\N	8
324	33	4	1	\N	\N	\N	7	\N	\N	f	\N	\N	6
197	20	6	0	white	\N	\N	7	\N	Green Volume Off	t	2021-12-07	\N	6
190	20	2	0	pink	\N	circles	7	\N	\N	t	2021-12-07	\N	1
325	33	5	0	\N	\N	\N	7	\N	\N	f	\N	\N	7
326	33	\N	0	\N	\N	\N	7	\N	Progressive Traverse	f	\N	\N	8
277	27	4	0	white	\N	\N	1	\N	Edge On	t	2021-09-16	\N	0
275	27	3	-1	purple	\N	\N	7	\N	Edge Off	t	2021-09-16	\N	9
327	33	\N	0	\N	\N	\N	19	4	Pop Up! / Youth Program	f	\N	\N	9
447	35	4	0	red	\N	\N	7	\N	\N	t	2022-04-07	\N	9
448	35	2	1	green	\N	\N	7	\N	Left	t	2022-04-07	\N	11
253	25	4	0	pink	\N	\N	7	\N	Edges Off	t	2022-02-03	\N	0
256	25	\N	0	green	\N	\N	7	\N	Scott's Chimney	t	2022-02-08	\N	2
255	25	\N	0	blue	\N	\N	7	\N	Scott's Crack	t	2022-02-08	\N	3
254	25	\N	0	orange	\N	\N	7	\N	\N	t	2022-02-10	\N	5
443	35	4	0	pink	\N	\N	5	\N	\N	t	2022-04-07	\N	0
444	35	3	1	purple	\N	\N	5	\N	No Stem	t	2022-04-07	\N	3
495	7	\N	0	green	\N	\N	7	\N	Project, Edges Off	t	2021-04-28	\N	1
348	35	3	-1	\N	\N	\N	7	\N	Traverse	f	\N	\N	11
349	35	3	0	\N	\N	\N	7	\N	Elimination	f	\N	\N	12
350	35	3	0	\N	\N	\N	7	\N	Sit Start	f	\N	\N	13
351	35	3	0	\N	\N	\N	3	\N	Edge On	f	\N	\N	14
352	35	3	1	\N	\N	\N	7	\N	\N	f	\N	\N	15
353	35	4	0	\N	\N	\N	7	\N	Sit Start	f	\N	\N	16
354	35	4	-1	\N	\N	\N	7	\N	\N	f	\N	\N	17
445	35	3	1	blue	\N	\N	7	\N	\N	t	2022-04-07	\N	5
287	29	-1	0	white	\N	\N	7	\N	\N	t	2021-07-13	\N	0
224	22	4	0	orange	\N	\N	7	\N	Top Out High	t	2021-12-23	\N	5
225	22	4	0	pink	black	\N	7	\N	Top Edge Off Sit Start	t	2021-12-30	\N	1
226	22	5	1	black	\N	\N	7	\N	Stem Off To High	t	2021-12-23	\N	10
227	22	6	0	yellow	\N	\N	7	\N	Stem Off To High	t	2021-12-23	\N	11
223	22	4	0	purple	\N	\N	7	\N	No Top Out	t	2021-12-30	\N	12
221	22	3	0	red	\N	\N	7	\N	No Top Out	t	2021-12-23	\N	13
228	22	\N	0	pink	\N	\N	7	\N	Project No Top Out	t	2021-12-30	\N	14
299	29	4	-1	white	\N	\N	7	\N	\N	t	2021-07-13	\N	2
298	29	3	1	blue	\N	\N	7	\N	\N	t	2021-07-15	\N	5
297	29	3	1	blue	\N	\N	7	\N	Cave Start	t	2021-07-13	\N	9
300	29	4	0	yellow	\N	\N	7	\N	Cave Start	t	\N	\N	12
302	29	\N	0	purple	\N	\N	7	\N	Project	t	2021-07-15	\N	14
301	29	5	-1	black	\N	\N	7	\N	Stem off	t	2021-07-15	\N	8
418	18	\N	0	yellow	\N	double line	7	\N	Open Feet	t	2022-03-22	\N	6
420	20	5	0	blue	\N	stars	7	\N	\N	t	2021-12-07	\N	2
269	26	\N	0	white	\N	sine w/ dots	4	\N	Pop Up!	t	2021-12-17	\N	10
355	35	4	1	\N	\N	\N	7	\N	Volume Off	f	\N	\N	18
435	34	3	-1	yellow	\N	\N	5	\N	\N	t	2021-04-07	\N	1
507	2	\N	0	white	\N	YP	1	\N	Youth Project	t	2022-05-02	\N	6
398	42	3	0	\N	\N	\N	7	\N	Slip N' Slide	f	\N	\N	4
399	42	2	0	\N	\N	\N	7	\N	This Is What Feet Are Made Of	f	\N	\N	5
514	6	1	1	red	\N	\N	7	\N	Left, Open Feet	t	2022-05-03	\N	1
496	7	1	0	orange	\N	\N	5	\N	\N	t	2021-04-28	\N	2
502	1	2	1	pink	\N	\N	7	\N	Sit Start	t	2022-05-03	\N	9
400	42	1	0	\N	\N	\N	7	\N	Your Lefts Are Your Rights	f	\N	\N	6
424	42	2	0	\N	\N	\N	7	\N	Pinched Cheeks	t	2022-04-01	\N	2
426	42	3	0	\N	\N	\N	7	\N	Not a Rock	t	2022-04-01	\N	4
267	26	4	1	green	\N	\N	7	\N	Edge Off	t	2021-09-14	\N	0
265	26	3	0	black	\N	\N	7	\N	Edge Off	t	2021-09-16	\N	5
264	26	3	0	yellow	\N	\N	7	\N	\N	t	2021-09-16	\N	6
268	26	5	-1	blue	\N	\N	7	\N	Edge Off	t	2021-09-16	\N	7
263	26	3	0	purple	\N	\N	7	\N	Edge Off	t	2021-09-16	\N	11
428	42	1	0	\N	\N	\N	7	\N	Plastique	t	2022-04-01	\N	6
179	19	3	1	pink	\N	triangle wave	5	\N	\N	t	2022-03-19	\N	9
180	19	6	-1	pink	\N	\N	7	\N	Pink	t	2022-03-10	\N	10
181	19	5	0	black	\N	\N	7	\N	Scott's Nemesis	t	2022-03-08	\N	11
182	19	2	1	red	\N	\N	16	\N	\N	t	2022-03-01	\N	12
183	19	4	0	white	\N	\N	7	\N	\N	t	2022-03-08	\N	13
184	19	3	0	yellow	\N	\N	7	\N	\N	t	2022-03-08	\N	14
171	19	6	0	orange	\N	\N	7	11	\N	t	2022-03-03	\N	0
453	32	1	1	black	\N	\N	5	\N	\N	t	2022-04-12	\N	2
452	32	2	0	blue	\N	\N	7	\N	\N	t	2022-04-12	\N	0
434	34	3	-1	blue	\N	\N	7	\N	Left Holds Only	t	2022-04-07	\N	0
429	32	2	1	purple	\N	\N	5	\N	\N	t	2022-04-05	\N	1
454	32	5	0	yellow	\N	sine wave	11	\N	\N	t	2022-04-08	\N	3
436	34	1	0	blue	\N	\N	5	\N	Right Holds Only	t	2022-04-07	\N	5
455	32	2	1	orange	\N	\N	7	\N	\N	t	2022-04-12	\N	4
451	32	5	-1	pink	\N	\N	11	\N	\N	t	2022-04-07	\N	5
446	35	4	1	purple	\N	\N	5	\N	No Right Stem	t	2022-04-05	\N	7
439	34	3	0	yellow	\N	\N	7	\N	Sit Start	t	2022-04-07	\N	8
438	34	5	0	black	\N	\N	7	\N	Stem Off	t	2022-04-07	\N	9
432	33	4	1	purple	\N	\N	5	\N	No Stem	t	2022-04-05	\N	8
430	33	4	1	red	\N	\N	7	\N	Features Off	t	2022-04-07	\N	5
431	33	4	0	green	\N	\N	7	\N	\N	t	2022-04-07	\N	4
456	33	5	-1	green	\N	\N	5	\N	Tracking	t	2022-04-12	\N	0
433	33	3	0	pink	\N	\N	5	\N	\N	t	2022-04-05	\N	9
440	34	3	1	green	\N	\N	7	\N	Stem Off	t	2022-04-07	\N	12
458	33	0	0	orange	\N	\N	5	\N	\N	t	2022-04-05	\N	2
457	33	1	0	blue	\N	\N	7	\N	\N	t	2022-04-12	\N	1
459	33	2	-1	white	\N	\N	7	\N	Open Feet	t	2022-04-12	\N	3
463	34	1	0	pink	\N	\N	5	\N	No Edge	t	2022-04-12	\N	3
467	35	2	-1	blue	\N	\N	7	\N	\N	t	2022-04-12	\N	1
468	35	1	0	green	\N	\N	7	\N	\N	t	2022-04-12	\N	2
475	35	5	1	yellow	\N	\N	7	\N	\N	t	2022-04-14	\N	6
472	33	4	-1	yellow	\N	triangles	7	\N	Stem Off	t	2022-04-14	\N	6
16	2	4	0	black	\N	\N	1	\N	Edge Off	f	2021-09-02	\N	5
11	2	2	-1	purple	\N	\N	7	\N	\N	f	2021-09-02	\N	9
12	2	2	0	yellow	\N	\N	7	\N	\N	f	2021-09-02	\N	4
8	2	0	0	black	\N	\N	7	\N	\N	f	2021-08-31	\N	10
7	2	\N	0	white	\N	YP	1	\N	Youth Program - Bird Bath	f	2021-08-09	\N	6
15	2	4	-1	blue	\N	\N	1	\N	Sit Start	f	2021-09-02	\N	7
29	4	2	-1	blue	\N	\N	7	\N	Left	f	2021-09-02	\N	6
30	4	2	1	orange	\N	\N	7	\N	Dyno	f	2021-08-31	\N	5
32	4	5	0	purple	\N	\N	7	\N	Left Open Feet	f	2021-09-02	\N	8
31	4	3	0	purple	\N	\N	7	\N	Right Open Feet	f	2021-09-02	\N	9
27	4	\N	0	white	\N	YP	1	\N	Youth Program	f	2021-10-04	\N	10
488	4	3	0	red	\N	\N	7	\N	\N	t	2021-04-26	\N	2
489	4	4	0	black	\N	\N	7	\N	\N	t	2021-04-28	\N	3
524	4	5	-1	green	\N	\N	7	\N	\N	t	2022-05-05	\N	1
505	2	2	-1	black	\N	\N	7	\N	\N	t	2022-05-03	\N	3
503	2	\N	0	purple	\N	\N	7	\N	\N	t	2022-05-03	\N	0
482	2	3	1	yellow	\N	\N	7	\N	Edges Off	t	2021-04-28	\N	7
484	2	2	0	purple	\N	\N	7	\N	\N	t	2021-04-28	\N	11
519	2	5	0	pink	\N	\N	5	\N	\N	t	2022-05-04	\N	9
520	2	5	0	orange	\N	\N	7	\N	\N	t	2022-05-05	\N	10
521	2	\N	0	white	\N	\N	7	\N	Open Feet	t	2022-05-05	\N	12
525	5	5	0	pink	\N	\N	7	\N	\N	t	2022-05-05	\N	1
515	6	1	0	red	\N	\N	7	\N	Right, Open Feet	t	2022-05-03	\N	2
497	7	3	0	black	\N	\N	5	\N	No Edge	t	2021-04-26	\N	3
498	7	4	1	red	\N	\N	5	\N	\N	t	2021-04-28	\N	4
499	7	2	1	blue	\N	\N	5	\N	\N	t	2021-04-28	\N	5
485	3	2	1	orange	\N	\N	5	\N	\N	t	2021-04-28	\N	0
486	3	3	0	yellow	\N	\N	7	\N	\N	t	2021-04-28	\N	2
508	3	3	0	purple	\N	\N	7	\N	\N	t	2022-05-03	\N	4
509	3	1	1	red	\N	\N	7	\N	\N	t	2022-05-03	\N	5
522	3	4	0	green	\N	sine wave	11	\N	\N	t	2022-05-05	\N	6
510	3	2	0	yellow	\N	\N	16	\N	\N	t	2022-05-03	\N	8
523	3	\N	0	blue	\N	\N	16	\N	Edge Off	t	2022-05-05	\N	7
526	3	\N	0	yellow	\N	sine wave	7	\N	Fig 4, Right Stem Off, Edges Off	t	2022-05-05	\N	1
476	1	-1	0	green	\N	\N	7	\N	\N	t	2022-04-26	\N	3
518	1	4	0	orange	\N	\N	7	\N	Edges Off	t	2022-05-05	\N	5
479	1	4	-1	blue	\N	\N	5	\N	\N	t	2021-04-26	\N	8
517	1	\N	0	white	\N	8	7	\N	Figure Eight, Open Feet	t	2022-05-05	\N	2
527	1	2	1	orange	\N	\N	4	\N	No Features, So Long And Thanks For All The Fish	t	2022-05-13	\N	7
\.


ALTER TABLE routes ENABLE TRIGGER ALL;

--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: climbingwall; Owner: postgres
--

SELECT pg_catalog.setval('routes_id_seq', 527, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: climbingwall; Owner: postgres
--

SELECT pg_catalog.setval('sections_id_seq', 22, true);


--
-- Name: setters_id_seq; Type: SEQUENCE SET; Schema: climbingwall; Owner: postgres
--

SELECT pg_catalog.setval('setters_id_seq', 19, true);


--
-- Name: subsections_id_seq; Type: SEQUENCE SET; Schema: climbingwall; Owner: postgres
--

SELECT pg_catalog.setval('subsections_id_seq', 44, true);


--
-- PostgreSQL database dump complete
--

