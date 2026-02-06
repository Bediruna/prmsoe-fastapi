-- Demo seed data for user c877835e-4609-4075-9892-84bf9c3e8f97
-- Idempotent: all INSERTs use ON CONFLICT DO NOTHING

-- ============================================================
-- Profile
-- ============================================================
INSERT INTO profiles (id, mission_statement, intent_type, created_at)
VALUES (
  'c877835e-4609-4075-9892-84bf9c3e8f97',
  'Reduce food waste in restaurant supply chains through AI-powered demand forecasting',
  'VALIDATION',
  now() - interval '30 days'
)
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- Contacts (40 total)
-- Using deterministic UUIDs (v5-style) for idempotency
-- ============================================================

-- Helper: set user_id once
DO $$
DECLARE
  uid uuid := 'c877835e-4609-4075-9892-84bf9c3e8f97';
  -- Contact UUIDs (deterministic, hand-crafted for demo)
  -- NEW (5)
  c01 uuid := 'a0000001-0001-4000-8000-000000000001';
  c02 uuid := 'a0000001-0001-4000-8000-000000000002';
  c03 uuid := 'a0000001-0001-4000-8000-000000000003';
  c04 uuid := 'a0000001-0001-4000-8000-000000000004';
  c05 uuid := 'a0000001-0001-4000-8000-000000000005';
  -- RESEARCHING (3)
  c06 uuid := 'a0000001-0001-4000-8000-000000000006';
  c07 uuid := 'a0000001-0001-4000-8000-000000000007';
  c08 uuid := 'a0000001-0001-4000-8000-000000000008';
  -- DRAFT_READY (5)
  c09 uuid := 'a0000001-0001-4000-8000-000000000009';
  c10 uuid := 'a0000001-0001-4000-8000-000000000010';
  c11 uuid := 'a0000001-0001-4000-8000-000000000011';
  c12 uuid := 'a0000001-0001-4000-8000-000000000012';
  c13 uuid := 'a0000001-0001-4000-8000-000000000013';
  -- SENT (25)
  c14 uuid := 'a0000001-0001-4000-8000-000000000014';
  c15 uuid := 'a0000001-0001-4000-8000-000000000015';
  c16 uuid := 'a0000001-0001-4000-8000-000000000016';
  c17 uuid := 'a0000001-0001-4000-8000-000000000017';
  c18 uuid := 'a0000001-0001-4000-8000-000000000018';
  c19 uuid := 'a0000001-0001-4000-8000-000000000019';
  c20 uuid := 'a0000001-0001-4000-8000-000000000020';
  c21 uuid := 'a0000001-0001-4000-8000-000000000021';
  c22 uuid := 'a0000001-0001-4000-8000-000000000022';
  c23 uuid := 'a0000001-0001-4000-8000-000000000023';
  c24 uuid := 'a0000001-0001-4000-8000-000000000024';
  c25 uuid := 'a0000001-0001-4000-8000-000000000025';
  c26 uuid := 'a0000001-0001-4000-8000-000000000026';
  c27 uuid := 'a0000001-0001-4000-8000-000000000027';
  c28 uuid := 'a0000001-0001-4000-8000-000000000028';
  c29 uuid := 'a0000001-0001-4000-8000-000000000029';
  c30 uuid := 'a0000001-0001-4000-8000-000000000030';
  c31 uuid := 'a0000001-0001-4000-8000-000000000031';
  c32 uuid := 'a0000001-0001-4000-8000-000000000032';
  c33 uuid := 'a0000001-0001-4000-8000-000000000033';
  c34 uuid := 'a0000001-0001-4000-8000-000000000034';
  c35 uuid := 'a0000001-0001-4000-8000-000000000035';
  c36 uuid := 'a0000001-0001-4000-8000-000000000036';
  c37 uuid := 'a0000001-0001-4000-8000-000000000037';
  c38 uuid := 'a0000001-0001-4000-8000-000000000038';
  -- ARCHIVED (2)
  c39 uuid := 'a0000001-0001-4000-8000-000000000039';
  c40 uuid := 'a0000001-0001-4000-8000-000000000040';

BEGIN

-- ============================================================
-- CONTACTS
-- ============================================================

-- NEW (5) — created 1-3 days ago
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, created_at) VALUES
  (c01, uid, 'Sarah Chen', 'https://linkedin.com/in/sarah-chen-demo', 'VP of Operations', 'FreshTrack Logistics', 'NEW', now() - interval '1 day'),
  (c02, uid, 'David Okonkwo', 'https://linkedin.com/in/david-okonkwo-demo', 'Head of Sustainability', 'GreenPlate Foods', 'NEW', now() - interval '2 days'),
  (c03, uid, 'Maria Santos', 'https://linkedin.com/in/maria-santos-demo', 'Supply Chain Director', 'ColdChain Solutions', 'NEW', now() - interval '1 day'),
  (c04, uid, 'James Morrison', 'https://linkedin.com/in/james-morrison-demo', 'COO', 'FarmToFork Inc', 'NEW', now() - interval '3 days'),
  (c05, uid, 'Aisha Patel', 'https://linkedin.com/in/aisha-patel-demo', 'Director of Procurement', 'BiteBox Restaurants', 'NEW', now() - interval '2 days')
ON CONFLICT (id) DO NOTHING;

-- RESEARCHING (3) — created 4-6 days ago
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, created_at) VALUES
  (c06, uid, 'Tom Nguyen', 'https://linkedin.com/in/tom-nguyen-demo', 'CTO', 'WasteNot Technologies', 'RESEARCHING', now() - interval '4 days'),
  (c07, uid, 'Lisa Johansson', 'https://linkedin.com/in/lisa-johansson-demo', 'Head of Innovation', 'Nordic Fresh AB', 'RESEARCHING', now() - interval '5 days'),
  (c08, uid, 'Raj Mehta', 'https://linkedin.com/in/raj-mehta-demo', 'VP Supply Chain', 'Spice Route Distributors', 'RESEARCHING', now() - interval '6 days')
ON CONFLICT (id) DO NOTHING;

-- DRAFT_READY (5) — created 5-10 days ago, with drafts and strategies
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c09, uid, 'Emily Watson', 'https://linkedin.com/in/emily-watson-demo', 'Director of Operations', 'UrbanBites Group', 'DRAFT_READY', 'PAIN_POINT',
   'Hi Emily, I noticed UrbanBites has been scaling rapidly across metro areas — congrats on the growth. With that expansion, I imagine keeping food waste under control across multiple locations becomes exponentially harder. We''re building an AI forecasting tool that helps multi-location restaurant groups cut waste by 25-30%. Would love to hear how you''re currently tackling this.',
   now() - interval '7 days'),
  (c10, uid, 'Carlos Rivera', 'https://linkedin.com/in/carlos-rivera-demo', 'Sustainability Manager', 'Pacific Seafood Co', 'DRAFT_READY', 'VALIDATION_ASK',
   'Hi Carlos, I''m researching how seafood distributors handle demand volatility — especially with perishable inventory. We''re validating whether AI-based demand forecasting could meaningfully reduce spoilage in the seafood supply chain. Would you be open to a 15-min chat to share your perspective?',
   now() - interval '8 days'),
  (c11, uid, 'Nina Kowalski', 'https://linkedin.com/in/nina-kowalski-demo', 'VP of Culinary', 'Harvest Kitchen Co', 'DRAFT_READY', 'INDUSTRY_TREND',
   'Hi Nina, I''ve been following the trend of ghost kitchens adopting data-driven inventory management — seems like the industry is finally catching up. Curious how Harvest Kitchen is thinking about demand forecasting as you scale your virtual brand portfolio.',
   now() - interval '9 days'),
  (c12, uid, 'Marcus Thompson', 'https://linkedin.com/in/marcus-thompson-demo', 'Head of Logistics', 'CleanPlate Catering', 'DRAFT_READY', 'DIRECT_PITCH',
   'Hi Marcus, we''ve built an AI demand forecasting tool that helps catering companies reduce food waste by 30% and cut over-ordering costs. Given CleanPlate''s focus on sustainable catering, I think there''s a strong fit. Happy to show you a quick demo.',
   now() - interval '6 days'),
  (c13, uid, 'Yuki Tanaka', 'https://linkedin.com/in/yuki-tanaka-demo', 'Operations Lead', 'Zen Bowl Fast Casual', 'DRAFT_READY', 'MUTUAL_CONNECTION',
   'Hi Yuki, I was chatting with a mutual contact in the fast-casual space and your name came up as someone deeply thoughtful about operational efficiency. We''re working on AI-powered demand forecasting for restaurant chains — would love to get your take on whether this solves a real problem for operators like you.',
   now() - interval '5 days')
ON CONFLICT (id) DO NOTHING;

-- SENT (25) — created 10-30 days ago
-- PAIN_POINT strategy (8): c14-c21
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c14, uid, 'Rachel Kim', 'https://linkedin.com/in/rachel-kim-demo', 'VP Operations', 'TasteLoop Restaurants', 'SENT', 'PAIN_POINT',
   'Hi Rachel, restaurant groups like TasteLoop often struggle with balancing prep quantities across locations. We''re building an AI tool to solve exactly that.',
   now() - interval '25 days'),
  (c15, uid, 'Michael O''Brien', 'https://linkedin.com/in/michael-obrien-demo', 'Director of F&B', 'Grandview Hotel Group', 'SENT', 'PAIN_POINT',
   'Hi Michael, hotel F&B is notoriously hard to forecast — seasonal guests, events, variable covers. We''re tackling this with AI demand prediction.',
   now() - interval '24 days'),
  (c16, uid, 'Fatima Al-Hassan', 'https://linkedin.com/in/fatima-alhassan-demo', 'Supply Chain Lead', 'MealPrep Nation', 'SENT', 'PAIN_POINT',
   'Hi Fatima, meal prep companies face unique forecasting challenges with subscription fluctuations. We''re building a solution for exactly this.',
   now() - interval '22 days'),
  (c17, uid, 'Jake Williams', 'https://linkedin.com/in/jake-williams-demo', 'COO', 'QuickServe Holdings', 'SENT', 'PAIN_POINT',
   'Hi Jake, QSR waste margins are razor-thin. We''re working on AI forecasting that could save chains like QuickServe 20-30% on waste costs.',
   now() - interval '20 days'),
  (c18, uid, 'Priya Sharma', 'https://linkedin.com/in/priya-sharma-demo', 'Head of Procurement', 'Dine Collective', 'SENT', 'PAIN_POINT',
   'Hi Priya, procurement at multi-brand restaurant groups is a forecasting nightmare. We''re building AI to make it predictable.',
   now() - interval '18 days'),
  (c19, uid, 'Andre Laurent', 'https://linkedin.com/in/andre-laurent-demo', 'Operations Director', 'Bistro Partners EU', 'SENT', 'PAIN_POINT',
   'Hi Andre, European bistro groups face tight waste regulations and slim margins. Our AI tool helps predict demand to minimize both waste and stockouts.',
   now() - interval '15 days'),
  (c20, uid, 'Sophie Zhang', 'https://linkedin.com/in/sophie-zhang-demo', 'VP Sustainability', 'CloudKitchens Asia', 'SENT', 'PAIN_POINT',
   'Hi Sophie, cloud kitchens produce surprisingly high waste due to demand unpredictability. We''re building a forecasting layer to fix that.',
   now() - interval '12 days'),
  (c21, uid, 'Ben Carter', 'https://linkedin.com/in/ben-carter-demo', 'Supply Chain VP', 'FreshBox Delivery', 'SENT', 'PAIN_POINT',
   'Hi Ben, meal kit delivery waste from over-production is a known challenge. Our AI forecasting could help FreshBox nail order quantities.',
   now() - interval '10 days')
ON CONFLICT (id) DO NOTHING;

-- VALIDATION_ASK strategy (7): c22-c28
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c22, uid, 'Diana Morales', 'https://linkedin.com/in/diana-morales-demo', 'Head of R&D', 'Sustainable Eats Inc', 'SENT', 'VALIDATION_ASK',
   'Hi Diana, we''re researching whether AI demand forecasting is a top priority for sustainability-focused food companies. Would love your perspective.',
   now() - interval '23 days'),
  (c23, uid, 'Oliver Strand', 'https://linkedin.com/in/oliver-strand-demo', 'CEO', 'NordicMeal Tech', 'SENT', 'VALIDATION_ASK',
   'Hi Oliver, we''re validating whether Nordic food-tech companies see demand forecasting as a gap in their stack. Quick 15-min chat?',
   now() - interval '21 days'),
  (c24, uid, 'Grace Liu', 'https://linkedin.com/in/grace-liu-demo', 'Product Manager', 'FoodLoop Platform', 'SENT', 'VALIDATION_ASK',
   'Hi Grace, we''re testing the hypothesis that food redistribution platforms need better upstream demand prediction. Does this resonate?',
   now() - interval '19 days'),
  (c25, uid, 'Hassan Yilmaz', 'https://linkedin.com/in/hassan-yilmaz-demo', 'Director of Strategy', 'Anatolian Foods', 'SENT', 'VALIDATION_ASK',
   'Hi Hassan, we''re exploring how large food manufacturers think about reducing waste through forecasting. Would value your insights.',
   now() - interval '17 days'),
  (c26, uid, 'Chloe Martin', 'https://linkedin.com/in/chloe-martin-demo', 'Innovation Lead', 'FrancoRestaurants SA', 'SENT', 'VALIDATION_ASK',
   'Hi Chloe, we''re validating whether European restaurant chains would adopt AI forecasting to meet new EU food waste regulations. Thoughts?',
   now() - interval '14 days'),
  (c27, uid, 'Kevin Park', 'https://linkedin.com/in/kevin-park-demo', 'VP Engineering', 'SmartCart Grocery', 'SENT', 'VALIDATION_ASK',
   'Hi Kevin, we''re researching grocery tech stacks to see where AI demand forecasting fits. Would love to understand SmartCart''s approach.',
   now() - interval '11 days'),
  (c28, uid, 'Laura Fischer', 'https://linkedin.com/in/laura-fischer-demo', 'Sustainability Director', 'Alpine Hospitality', 'SENT', 'VALIDATION_ASK',
   'Hi Laura, curious if Alpine Hospitality has explored predictive tools for reducing food waste across your resort properties.',
   now() - interval '8 days')
ON CONFLICT (id) DO NOTHING;

-- DIRECT_PITCH strategy (5): c29-c33
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c29, uid, 'Steve Robinson', 'https://linkedin.com/in/steve-robinson-demo', 'COO', 'Metro Dining Group', 'SENT', 'DIRECT_PITCH',
   'Hi Steve, we''ve built an AI tool that cuts restaurant food waste by 30%. Given Metro Dining''s scale, this could save millions annually. Quick demo?',
   now() - interval '20 days'),
  (c30, uid, 'Anna Petrova', 'https://linkedin.com/in/anna-petrova-demo', 'Head of Operations', 'Eastern Flavors Chain', 'SENT', 'DIRECT_PITCH',
   'Hi Anna, our AI demand forecasting reduces food waste 25-30% for restaurant chains. Would love to show you how it would work for Eastern Flavors.',
   now() - interval '18 days'),
  (c31, uid, 'Ryan McGrath', 'https://linkedin.com/in/ryan-mcgrath-demo', 'VP Supply Chain', 'FastFuel QSR', 'SENT', 'DIRECT_PITCH',
   'Hi Ryan, our tool predicts daily demand per menu item with 92% accuracy. For QSR chains like FastFuel, that means major waste reduction.',
   now() - interval '16 days'),
  (c32, uid, 'Monica Alvarez', 'https://linkedin.com/in/monica-alvarez-demo', 'Operations Manager', 'TacoTrail Franchise', 'SENT', 'DIRECT_PITCH',
   'Hi Monica, we help franchise operators forecast ingredient needs across locations. TacoTrail''s growth makes this especially relevant.',
   now() - interval '13 days'),
  (c33, uid, 'Daniel Ek', 'https://linkedin.com/in/daniel-ek-food-demo', 'CEO', 'PlantBased Kitchens', 'SENT', 'DIRECT_PITCH',
   'Hi Daniel, plant-based ingredients have short shelf lives making forecasting critical. Our AI tool is purpose-built for this.',
   now() - interval '10 days')
ON CONFLICT (id) DO NOTHING;

-- MUTUAL_CONNECTION strategy (3): c34-c36
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c34, uid, 'Rebecca Zhao', 'https://linkedin.com/in/rebecca-zhao-demo', 'Director of Ops', 'DimSum Express', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Rebecca, our mutual connection Alex from FoodTech Ventures mentioned you''re thinking deeply about operational efficiency at DimSum Express.',
   now() - interval '19 days'),
  (c35, uid, 'Chris Andersen', 'https://linkedin.com/in/chris-andersen-demo', 'Head of Strategy', 'Scandinavian Bistros', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Chris, Marta from the FoodTech Summit mentioned you''d be great to talk to about demand forecasting challenges in Nordic restaurants.',
   now() - interval '15 days'),
  (c36, uid, 'Nadia Popov', 'https://linkedin.com/in/nadia-popov-demo', 'VP Innovation', 'EastWest Catering', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Nadia, we have a few mutual connections in the catering world. Heard EastWest is exploring tech solutions for waste — we should chat.',
   now() - interval '11 days')
ON CONFLICT (id) DO NOTHING;

-- INDUSTRY_TREND strategy (2): c37-c38
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c37, uid, 'Alex Petrov', 'https://linkedin.com/in/alex-petrov-demo', 'CTO', 'SmartKitchen.io', 'SENT', 'INDUSTRY_TREND',
   'Hi Alex, the restaurant tech industry is moving fast toward predictive analytics. Curious how SmartKitchen.io is thinking about demand forecasting.',
   now() - interval '14 days'),
  (c38, uid, 'Isabella Rossi', 'https://linkedin.com/in/isabella-rossi-demo', 'Innovation Director', 'Gusto Italiano Group', 'SENT', 'INDUSTRY_TREND',
   'Hi Isabella, EU food waste regulations are pushing Italian restaurant groups to adopt tech solutions. We''re building AI forecasting for exactly this shift.',
   now() - interval '10 days')
ON CONFLICT (id) DO NOTHING;

-- ARCHIVED (2)
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, created_at) VALUES
  (c39, uid, 'Bob Franklin', 'https://linkedin.com/in/bob-franklin-demo', 'Retired Executive', 'Former FoodCorp', 'ARCHIVED', 'DIRECT_PITCH', now() - interval '28 days'),
  (c40, uid, 'Jean-Pierre Dubois', 'https://linkedin.com/in/jp-dubois-demo', 'Consultant', 'Independent', 'ARCHIVED', 'VALIDATION_ASK', now() - interval '26 days')
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- RESEARCH (35 — all contacts except the 5 NEW ones)
-- ============================================================

-- RESEARCHING contacts
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c06, 'WasteNot Technologies raised a $12M Series A to expand their food waste tracking platform to 500 new restaurant clients.', 'Real-time tracking of waste at kitchen level; integration with POS systems; ROI proof for restaurant operators.', 'https://techcrunch.com/demo/wastenot-series-a', now() - interval '4 days'),
  (gen_random_uuid(), c07, 'Nordic Fresh AB announced a partnership with IKEA Food Services to optimize supply chain sustainability across Scandinavian markets.', 'Cross-border supply chain complexity; seasonal demand spikes; cold chain integrity for fresh produce.', 'https://reuters.com/demo/nordic-fresh-ikea', now() - interval '5 days'),
  (gen_random_uuid(), c08, 'Spice Route Distributors expanded to 3 new warehouse locations to serve growing Indian restaurant demand in the UK.', 'Perishable spice inventory management; demand forecasting for ethnic cuisine trends; warehouse utilization rates.', 'https://foodnavigator.com/demo/spice-route-expansion', now() - interval '6 days')
ON CONFLICT (contact_id) DO NOTHING;

-- DRAFT_READY contacts
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c09, 'UrbanBites Group opened 15 new locations in Q4, bringing total to 85 restaurants across 12 cities.', 'Scaling procurement across new locations; inconsistent waste metrics between sites; training new kitchen staff on portion control.', 'https://restaurantbusinessonline.com/demo/urbanbites-expansion', now() - interval '7 days'),
  (gen_random_uuid(), c10, 'Pacific Seafood Co reported a 15% increase in spoilage costs due to unseasonable ocean temperature changes affecting catch volumes.', 'Highly perishable inventory with 24-48hr shelf life; volatile supply from fisheries; price fluctuations affecting menu planning.', 'https://seafoodsource.com/demo/pacific-spoilage', now() - interval '8 days'),
  (gen_random_uuid(), c11, 'Harvest Kitchen Co launched 3 new virtual restaurant brands, now operating 8 brands out of shared kitchen spaces.', 'Multi-brand demand forecasting from single kitchen; ingredient overlap optimization; delivery platform demand variability.', 'https://ghostkitchenreport.com/demo/harvest-virtual-brands', now() - interval '9 days'),
  (gen_random_uuid(), c12, 'CleanPlate Catering won the city of Portland''s contract for zero-waste corporate events, valued at $2M annually.', 'Event-based demand is inherently unpredictable; zero-waste commitment requires precise forecasting; penalty clauses for excess waste.', 'https://portlandbusinessjournal.com/demo/cleanplate-contract', now() - interval '6 days'),
  (gen_random_uuid(), c13, 'Zen Bowl Fast Casual raised $5M seed round to expand from 4 to 20 locations, focusing on data-driven operations.', 'Rapid scaling with lean ops team; consistency across franchise locations; fresh ingredient sourcing at scale.', 'https://fastcasual.com/demo/zen-bowl-funding', now() - interval '5 days')
ON CONFLICT (contact_id) DO NOTHING;

-- SENT contacts — PAIN_POINT (c14-c21)
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c14, 'TasteLoop Restaurants reported 12% food cost increase YoY, citing waste and over-ordering as top drivers.', 'Multi-location waste tracking; inconsistent ordering patterns; no centralized forecasting tool.', 'https://nationalsrestaurantnews.com/demo/tasteloop-costs', now() - interval '25 days'),
  (gen_random_uuid(), c15, 'Grandview Hotel Group is investing $50M in sustainability initiatives, including food waste reduction across 200 properties.', 'Banquet and event waste is massive; room service demand is unpredictable; brand reputation tied to sustainability.', 'https://hotelmanagement.net/demo/grandview-sustainability', now() - interval '24 days'),
  (gen_random_uuid(), c16, 'MealPrep Nation saw 40% subscriber growth but waste increased 60% due to inaccurate demand predictions.', 'Subscription churn makes forecasting hard; ingredient pre-portioning waste; weekly menu rotation complexity.', 'https://mealprepsource.com/demo/mealprep-waste', now() - interval '22 days'),
  (gen_random_uuid(), c17, 'QuickServe Holdings is rolling out new menu items across 500 locations, requiring updated forecasting models.', 'New item demand is unpredictable; promotional spikes vs baseline; regional taste differences.', 'https://qsrmagazine.com/demo/quickserve-newmenu', now() - interval '20 days'),
  (gen_random_uuid(), c18, 'Dine Collective acquired two new restaurant brands, now managing 6 concepts with different supply needs.', 'Cross-brand procurement optimization; different supplier relationships per concept; consolidated waste reporting.', 'https://restaurantdive.com/demo/dine-collective', now() - interval '18 days'),
  (gen_random_uuid(), c19, 'Bistro Partners EU is adapting to new EU food waste reduction targets requiring 30% waste cut by 2028.', 'Regulatory compliance pressure; measurement and reporting requirements; need for predictive tools.', 'https://euractiv.com/demo/bistro-eu-waste', now() - interval '15 days'),
  (gen_random_uuid(), c20, 'CloudKitchens Asia expanded to 50 kitchen locations across Southeast Asia, operating 120 virtual brands.', 'Massive SKU complexity; hyper-local demand patterns; delivery platform algorithm changes affect order volume.', 'https://techasia.com/demo/cloudkitchens-expansion', now() - interval '12 days'),
  (gen_random_uuid(), c21, 'FreshBox Delivery reported $8M in annual losses from over-produced meal kits that go unsold.', 'Shelf-life constraints on pre-packed kits; forecast error compounds across ingredient BOM; last-mile logistics adds waste.', 'https://grocerydive.com/demo/freshbox-losses', now() - interval '10 days')
ON CONFLICT (contact_id) DO NOTHING;

-- SENT contacts — VALIDATION_ASK (c22-c28)
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c22, 'Sustainable Eats Inc published their annual impact report showing 18% food waste reduction through manual processes.', 'Manual tracking is labor-intensive; want to automate but unsure of ROI; need data to justify tech investment.', 'https://sustainableeats.com/demo/impact-report', now() - interval '23 days'),
  (gen_random_uuid(), c23, 'NordicMeal Tech won the Nordic Food Innovation Award for their farm-to-table supply chain platform.', 'Last mile freshness; Nordic seasonal demand shifts; integration with local farming cooperatives.', 'https://nordicfoodtech.com/demo/award', now() - interval '21 days'),
  (gen_random_uuid(), c24, 'FoodLoop Platform diverted 2M kg of food from landfills but still sees 30% of listed items expire before redistribution.', 'Timing mismatch between supply and demand; perishable logistics; need predictive matching not reactive.', 'https://impactalpha.com/demo/foodloop-diversion', now() - interval '19 days'),
  (gen_random_uuid(), c25, 'Anatolian Foods invested in a new production line for plant-based Turkish foods, targeting European supermarkets.', 'New product line demand forecasting; cross-cultural market sizing; shelf-life optimization for plant-based.', 'https://foodengineeringmag.com/demo/anatolian-plantbased', now() - interval '17 days'),
  (gen_random_uuid(), c26, 'FrancoRestaurants SA is piloting digital inventory management across 30 locations in preparation for EU mandates.', 'Legacy systems hinder data collection; staff resistance to new tools; need ROI proof within 6 months.', 'https://lemonde.fr/demo/franco-digital', now() - interval '14 days'),
  (gen_random_uuid(), c27, 'SmartCart Grocery deployed computer vision for shelf monitoring but lacks predictive ordering capabilities.', 'Reactive replenishment vs predictive; integration with existing CV stack; fresh produce forecasting complexity.', 'https://retaildive.com/demo/smartcart-cv', now() - interval '11 days'),
  (gen_random_uuid(), c28, 'Alpine Hospitality committed to carbon neutrality by 2027, with food waste identified as #2 contributor.', 'Seasonal resort demand swings; multiple F&B outlets per property; guest behavior unpredictability.', 'https://hospitalitynet.org/demo/alpine-carbon', now() - interval '8 days')
ON CONFLICT (contact_id) DO NOTHING;

-- SENT contacts — DIRECT_PITCH (c29-c33)
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c29, 'Metro Dining Group reported $15M in food waste across their 120 locations last fiscal year.', 'Scale amplifies waste; no unified ordering system; regional managers make independent procurement decisions.', 'https://restaurantbusinessonline.com/demo/metro-waste', now() - interval '20 days'),
  (gen_random_uuid(), c30, 'Eastern Flavors Chain is modernizing operations after a PE acquisition, with a focus on margins and efficiency.', 'Post-acquisition pressure to cut costs; diverse cuisine types complicate forecasting; staff turnover affects consistency.', 'https://privateequitywire.com/demo/eastern-flavors', now() - interval '18 days'),
  (gen_random_uuid(), c31, 'FastFuel QSR tested AI-driven drive-thru optimization, showing appetite for operational technology.', 'Already investing in AI; drive-thru waste from pre-made items; speed vs waste tradeoff.', 'https://qsrmagazine.com/demo/fastfuel-ai', now() - interval '16 days'),
  (gen_random_uuid(), c32, 'TacoTrail Franchise grew to 200 locations with franchisee-reported food cost variance of 8-15% across units.', 'Franchisee compliance with ordering guidelines; high variance indicates forecasting gaps; standardization challenges.', 'https://franchising.com/demo/tacotrail-variance', now() - interval '13 days'),
  (gen_random_uuid(), c33, 'PlantBased Kitchens faces 2x higher spoilage rates than traditional restaurants due to ingredient perishability.', 'Plant-based ingredients spoil faster; smaller batch sizes needed; demand still volatile for plant-based menu items.', 'https://vegconomist.com/demo/plantbased-spoilage', now() - interval '10 days')
ON CONFLICT (contact_id) DO NOTHING;

-- SENT contacts — MUTUAL_CONNECTION (c34-c36)
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c34, 'DimSum Express streamlined their menu to 25 items but still sees 20% waste on steamed items with short hold times.', 'Steamed/fresh items have minutes-long quality windows; peak hour demand spikes; cultural expectations of freshness.', 'https://chinatown-report.com/demo/dimsum-waste', now() - interval '19 days'),
  (gen_random_uuid(), c35, 'Scandinavian Bistros expanded their lunch concept to 40 locations with a focus on seasonal Nordic ingredients.', 'Seasonal ingredient availability; local sourcing constraints; lunch-only model means concentrated demand window.', 'https://scandinavianbusiness.com/demo/scandi-bistros', now() - interval '15 days'),
  (gen_random_uuid(), c36, 'EastWest Catering won contracts with 3 Fortune 500 companies for corporate dining, growing revenue 45%.', 'Corporate dining has predictable headcount but variable uptake; contract penalties for waste; multi-cuisine complexity.', 'https://cateringnews.com/demo/eastwest-f500', now() - interval '11 days')
ON CONFLICT (contact_id) DO NOTHING;

-- SENT contacts — INDUSTRY_TREND (c37-c38)
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c37, 'SmartKitchen.io raised $20M Series B to build an integrated restaurant OS with POS, inventory, and analytics.', 'Building an all-in-one platform; demand forecasting is a gap in their stack; potential partnership or integration opportunity.', 'https://techcrunch.com/demo/smartkitchen-seriesb', now() - interval '14 days'),
  (gen_random_uuid(), c38, 'Gusto Italiano Group is investing in tech modernization after family-run operations struggled with 200-location scale.', 'Traditional operations resisting tech; need simple, non-disruptive tools; Italian cuisine has high fresh-ingredient waste.', 'https://corriere.it/demo/gusto-italiano-tech', now() - interval '10 days')
ON CONFLICT (contact_id) DO NOTHING;

-- ARCHIVED contacts
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c39, 'Bob Franklin retired from FoodCorp after 30 years. No longer active in the industry.', 'N/A — contact is retired and no longer relevant.', 'https://linkedin.com/demo/bob-franklin-retirement', now() - interval '28 days'),
  (gen_random_uuid(), c40, 'Jean-Pierre Dubois pivoted to general management consulting, no longer focused on food industry.', 'N/A — contact has left the food industry.', 'https://linkedin.com/demo/jp-dubois-consulting', now() - interval '26 days')
ON CONFLICT (contact_id) DO NOTHING;


-- ============================================================
-- OUTREACH ATTEMPTS (25 — one per SENT contact)
-- ============================================================

-- PAIN_POINT: 8 sent, 4 REPLIED, 3 GHOSTED, 1 BOUNCED
-- c14: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c14, 'PAIN_POINT',
   'Hi Rachel, restaurant groups like TasteLoop often struggle with balancing prep quantities across locations. We''re building an AI tool to solve exactly that.',
   now() - interval '23 days', now() - interval '16 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c15: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c15, 'PAIN_POINT',
   'Hi Michael, hotel F&B is notoriously hard to forecast — seasonal guests, events, variable covers. We''re tackling this with AI demand prediction.',
   now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c16: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c16, 'PAIN_POINT',
   'Hi Fatima, meal prep companies face unique forecasting challenges with subscription fluctuations. We''re building a solution for exactly this.',
   now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c17: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c17, 'PAIN_POINT',
   'Hi Jake, QSR waste margins are razor-thin. We''re working on AI forecasting that could save chains like QuickServe 20-30% on waste costs.',
   now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c18: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c18, 'PAIN_POINT',
   'Hi Priya, procurement at multi-brand restaurant groups is a forecasting nightmare. We''re building AI to make it predictable.',
   now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c19: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c19, 'PAIN_POINT',
   'Hi Andre, European bistro groups face tight waste regulations and slim margins. Our AI tool helps predict demand to minimize both waste and stockouts.',
   now() - interval '13 days', now() - interval '6 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c20: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c20, 'PAIN_POINT',
   'Hi Sophie, cloud kitchens produce surprisingly high waste due to demand unpredictability. We''re building a forecasting layer to fix that.',
   now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c21: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c21, 'PAIN_POINT',
   'Hi Ben, meal kit delivery waste from over-production is a known challenge. Our AI forecasting could help FreshBox nail order quantities.',
   now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- VALIDATION_ASK: 7 sent, 3 REPLIED, 3 GHOSTED, 1 BOUNCED
-- c22: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c22, 'VALIDATION_ASK',
   'Hi Diana, we''re researching whether AI demand forecasting is a top priority for sustainability-focused food companies. Would love your perspective.',
   now() - interval '21 days', now() - interval '14 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c23: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c23, 'VALIDATION_ASK',
   'Hi Oliver, we''re validating whether Nordic food-tech companies see demand forecasting as a gap in their stack. Quick 15-min chat?',
   now() - interval '19 days', now() - interval '12 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c24: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c24, 'VALIDATION_ASK',
   'Hi Grace, we''re testing the hypothesis that food redistribution platforms need better upstream demand prediction. Does this resonate?',
   now() - interval '17 days', now() - interval '10 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c25: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c25, 'VALIDATION_ASK',
   'Hi Hassan, we''re exploring how large food manufacturers think about reducing waste through forecasting. Would value your insights.',
   now() - interval '15 days', now() - interval '8 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c26: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c26, 'VALIDATION_ASK',
   'Hi Chloe, we''re validating whether European restaurant chains would adopt AI forecasting to meet new EU food waste regulations. Thoughts?',
   now() - interval '12 days', now() - interval '5 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c27: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c27, 'VALIDATION_ASK',
   'Hi Kevin, we''re researching grocery tech stacks to see where AI demand forecasting fits. Would love to understand SmartCart''s approach.',
   now() - interval '9 days', now() - interval '2 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c28: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c28, 'VALIDATION_ASK',
   'Hi Laura, curious if Alpine Hospitality has explored predictive tools for reducing food waste across your resort properties.',
   now() - interval '6 days', now() - interval '1 day', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- DIRECT_PITCH: 5 sent, 1 REPLIED, 4 GHOSTED
-- c29: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c29, 'DIRECT_PITCH',
   'Hi Steve, we''ve built an AI tool that cuts restaurant food waste by 30%. Given Metro Dining''s scale, this could save millions annually. Quick demo?',
   now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c30: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c30, 'DIRECT_PITCH',
   'Hi Anna, our AI demand forecasting reduces food waste 25-30% for restaurant chains. Would love to show you how it would work for Eastern Flavors.',
   now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c31: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c31, 'DIRECT_PITCH',
   'Hi Ryan, our tool predicts daily demand per menu item with 92% accuracy. For QSR chains like FastFuel, that means major waste reduction.',
   now() - interval '14 days', now() - interval '7 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;
-- c32: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c32, 'DIRECT_PITCH',
   'Hi Monica, we help franchise operators forecast ingredient needs across locations. TacoTrail''s growth makes this especially relevant.',
   now() - interval '11 days', now() - interval '4 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;
-- c33: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c33, 'DIRECT_PITCH',
   'Hi Daniel, plant-based ingredients have short shelf lives making forecasting critical. Our AI tool is purpose-built for this.',
   now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- MUTUAL_CONNECTION: 3 sent, 2 REPLIED, 1 GHOSTED — but these 3 are PENDING feedback
-- c34: PENDING (feedback due in the past)
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c34, 'MUTUAL_CONNECTION',
   'Hi Rebecca, our mutual connection Alex from FoodTech Ventures mentioned you''re thinking deeply about operational efficiency at DimSum Express.',
   now() - interval '12 days', now() - interval '2 days', 'PENDING', NULL)
ON CONFLICT DO NOTHING;
-- c35: PENDING
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c35, 'MUTUAL_CONNECTION',
   'Hi Chris, Marta from the FoodTech Summit mentioned you''d be great to talk to about demand forecasting challenges in Nordic restaurants.',
   now() - interval '10 days', now() - interval '1 day', 'PENDING', NULL)
ON CONFLICT DO NOTHING;
-- c36: PENDING
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c36, 'MUTUAL_CONNECTION',
   'Hi Nadia, we have a few mutual connections in the catering world. Heard EastWest is exploring tech solutions for waste — we should chat.',
   now() - interval '8 days', now() - interval '1 day', 'PENDING', NULL)
ON CONFLICT DO NOTHING;

-- INDUSTRY_TREND: 2 sent, 0 REPLIED — these 2 are also PENDING
-- c37: PENDING
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c37, 'INDUSTRY_TREND',
   'Hi Alex, the restaurant tech industry is moving fast toward predictive analytics. Curious how SmartKitchen.io is thinking about demand forecasting.',
   now() - interval '9 days', now() - interval '2 days', 'PENDING', NULL)
ON CONFLICT DO NOTHING;
-- c38: PENDING
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c38, 'INDUSTRY_TREND',
   'Hi Isabella, EU food waste regulations are pushing Italian restaurant groups to adopt tech solutions. We''re building AI forecasting for exactly this shift.',
   now() - interval '7 days', now() - interval '1 day', 'PENDING', NULL)
ON CONFLICT DO NOTHING;


-- ============================================================
-- ENRICHMENT JOB (1)
-- ============================================================
INSERT INTO enrichment_jobs (id, user_id, total_contacts, processed_count, failed_count, status, created_at, completed_at) VALUES
  (gen_random_uuid(), uid, 40, 35, 0, 'COMPLETED', now() - interval '28 days', now() - interval '28 days' + interval '5 minutes')
ON CONFLICT DO NOTHING;


END $$;
