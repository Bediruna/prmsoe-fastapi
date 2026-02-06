-- Bulk demo seed: 75 more SENT contacts for user c877835e-...
-- Combined with first migration = 100 SENT contacts total
-- Idempotent: ON CONFLICT DO NOTHING on all INSERTs

DO $$
DECLARE
  uid uuid := 'c877835e-4609-4075-9892-84bf9c3e8f97';

  -- PAIN_POINT (24): c41-c64
  c41 uuid := 'a0000001-0001-4000-8000-000000000041';
  c42 uuid := 'a0000001-0001-4000-8000-000000000042';
  c43 uuid := 'a0000001-0001-4000-8000-000000000043';
  c44 uuid := 'a0000001-0001-4000-8000-000000000044';
  c45 uuid := 'a0000001-0001-4000-8000-000000000045';
  c46 uuid := 'a0000001-0001-4000-8000-000000000046';
  c47 uuid := 'a0000001-0001-4000-8000-000000000047';
  c48 uuid := 'a0000001-0001-4000-8000-000000000048';
  c49 uuid := 'a0000001-0001-4000-8000-000000000049';
  c50 uuid := 'a0000001-0001-4000-8000-000000000050';
  c51 uuid := 'a0000001-0001-4000-8000-000000000051';
  c52 uuid := 'a0000001-0001-4000-8000-000000000052';
  c53 uuid := 'a0000001-0001-4000-8000-000000000053';
  c54 uuid := 'a0000001-0001-4000-8000-000000000054';
  c55 uuid := 'a0000001-0001-4000-8000-000000000055';
  c56 uuid := 'a0000001-0001-4000-8000-000000000056';
  c57 uuid := 'a0000001-0001-4000-8000-000000000057';
  c58 uuid := 'a0000001-0001-4000-8000-000000000058';
  c59 uuid := 'a0000001-0001-4000-8000-000000000059';
  c60 uuid := 'a0000001-0001-4000-8000-000000000060';
  c61 uuid := 'a0000001-0001-4000-8000-000000000061';
  c62 uuid := 'a0000001-0001-4000-8000-000000000062';
  c63 uuid := 'a0000001-0001-4000-8000-000000000063';
  c64 uuid := 'a0000001-0001-4000-8000-000000000064';

  -- VALIDATION_ASK (20): c65-c84
  c65 uuid := 'a0000001-0001-4000-8000-000000000065';
  c66 uuid := 'a0000001-0001-4000-8000-000000000066';
  c67 uuid := 'a0000001-0001-4000-8000-000000000067';
  c68 uuid := 'a0000001-0001-4000-8000-000000000068';
  c69 uuid := 'a0000001-0001-4000-8000-000000000069';
  c70 uuid := 'a0000001-0001-4000-8000-000000000070';
  c71 uuid := 'a0000001-0001-4000-8000-000000000071';
  c72 uuid := 'a0000001-0001-4000-8000-000000000072';
  c73 uuid := 'a0000001-0001-4000-8000-000000000073';
  c74 uuid := 'a0000001-0001-4000-8000-000000000074';
  c75 uuid := 'a0000001-0001-4000-8000-000000000075';
  c76 uuid := 'a0000001-0001-4000-8000-000000000076';
  c77 uuid := 'a0000001-0001-4000-8000-000000000077';
  c78 uuid := 'a0000001-0001-4000-8000-000000000078';
  c79 uuid := 'a0000001-0001-4000-8000-000000000079';
  c80 uuid := 'a0000001-0001-4000-8000-000000000080';
  c81 uuid := 'a0000001-0001-4000-8000-000000000081';
  c82 uuid := 'a0000001-0001-4000-8000-000000000082';
  c83 uuid := 'a0000001-0001-4000-8000-000000000083';
  c84 uuid := 'a0000001-0001-4000-8000-000000000084';

  -- DIRECT_PITCH (15): c85-c99
  c85 uuid := 'a0000001-0001-4000-8000-000000000085';
  c86 uuid := 'a0000001-0001-4000-8000-000000000086';
  c87 uuid := 'a0000001-0001-4000-8000-000000000087';
  c88 uuid := 'a0000001-0001-4000-8000-000000000088';
  c89 uuid := 'a0000001-0001-4000-8000-000000000089';
  c90 uuid := 'a0000001-0001-4000-8000-000000000090';
  c91 uuid := 'a0000001-0001-4000-8000-000000000091';
  c92 uuid := 'a0000001-0001-4000-8000-000000000092';
  c93 uuid := 'a0000001-0001-4000-8000-000000000093';
  c94 uuid := 'a0000001-0001-4000-8000-000000000094';
  c95 uuid := 'a0000001-0001-4000-8000-000000000095';
  c96 uuid := 'a0000001-0001-4000-8000-000000000096';
  c97 uuid := 'a0000001-0001-4000-8000-000000000097';
  c98 uuid := 'a0000001-0001-4000-8000-000000000098';
  c99 uuid := 'a0000001-0001-4000-8000-000000000099';

  -- MUTUAL_CONNECTION (10): c100-c109
  c100 uuid := 'a0000001-0001-4000-8000-000000000100';
  c101 uuid := 'a0000001-0001-4000-8000-000000000101';
  c102 uuid := 'a0000001-0001-4000-8000-000000000102';
  c103 uuid := 'a0000001-0001-4000-8000-000000000103';
  c104 uuid := 'a0000001-0001-4000-8000-000000000104';
  c105 uuid := 'a0000001-0001-4000-8000-000000000105';
  c106 uuid := 'a0000001-0001-4000-8000-000000000106';
  c107 uuid := 'a0000001-0001-4000-8000-000000000107';
  c108 uuid := 'a0000001-0001-4000-8000-000000000108';
  c109 uuid := 'a0000001-0001-4000-8000-000000000109';

  -- INDUSTRY_TREND (6): c110-c115
  c110 uuid := 'a0000001-0001-4000-8000-000000000110';
  c111 uuid := 'a0000001-0001-4000-8000-000000000111';
  c112 uuid := 'a0000001-0001-4000-8000-000000000112';
  c113 uuid := 'a0000001-0001-4000-8000-000000000113';
  c114 uuid := 'a0000001-0001-4000-8000-000000000114';
  c115 uuid := 'a0000001-0001-4000-8000-000000000115';

BEGIN

-- ============================================================
-- CONTACTS — PAIN_POINT (24)
-- ============================================================
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c41, uid, 'Samantha Lee', 'https://linkedin.com/in/samantha-lee-demo', 'Director of Operations', 'Golden Wok Restaurants', 'SENT', 'PAIN_POINT',
   'Hi Samantha, multi-location Asian restaurant groups lose up to 18% on ingredient waste due to variable demand. We''re building AI to fix that.',
   now() - interval '28 days'),
  (c42, uid, 'Robert Nakamura', 'https://linkedin.com/in/robert-nakamura-demo', 'VP Supply Chain', 'Sakura Dining Group', 'SENT', 'PAIN_POINT',
   'Hi Robert, Japanese restaurants waste significantly on fresh fish and produce. Our AI forecasting predicts daily demand per item to cut that waste.',
   now() - interval '27 days'),
  (c43, uid, 'Elena Volkov', 'https://linkedin.com/in/elena-volkov-demo', 'Head of Procurement', 'EuroFresh Distribution', 'SENT', 'PAIN_POINT',
   'Hi Elena, fresh food distributors face a unique pain — forecast wrong and you either waste perishables or lose sales. We''re solving this with AI.',
   now() - interval '27 days'),
  (c44, uid, 'Tyler Brooks', 'https://linkedin.com/in/tyler-brooks-demo', 'COO', 'SaladWorks Express', 'SENT', 'PAIN_POINT',
   'Hi Tyler, salad-focused chains have some of the shortest shelf lives in QSR. Our demand forecasting helps chains like yours prep exactly what sells.',
   now() - interval '26 days'),
  (c45, uid, 'Amara Osei', 'https://linkedin.com/in/amara-osei-demo', 'Operations Director', 'AfroSpice Kitchen', 'SENT', 'PAIN_POINT',
   'Hi Amara, ethnic cuisine restaurants often lack the data tools larger chains have. Our AI forecasting levels the playing field on waste reduction.',
   now() - interval '25 days'),
  (c46, uid, 'Peter Johansson', 'https://linkedin.com/in/peter-johansson-demo', 'Supply Chain Manager', 'ScandiCater AB', 'SENT', 'PAIN_POINT',
   'Hi Peter, catering in the Nordics has tight margins and strict sustainability requirements. Our AI tool helps predict event demand more accurately.',
   now() - interval '24 days'),
  (c47, uid, 'Michelle Tran', 'https://linkedin.com/in/michelle-tran-demo', 'VP Operations', 'Pho Republic Chain', 'SENT', 'PAIN_POINT',
   'Hi Michelle, pho restaurants waste heavily on broth prep and fresh herbs. AI demand forecasting can help Pho Republic prep the right volumes daily.',
   now() - interval '23 days'),
  (c48, uid, 'Jorge Gonzalez', 'https://linkedin.com/in/jorge-gonzalez-demo', 'Director of Logistics', 'TacoFiesta Corp', 'SENT', 'PAIN_POINT',
   'Hi Jorge, fast-casual Mexican chains face high waste on prepped ingredients with short hold times. Our AI predicts demand to cut that waste by 30%.',
   now() - interval '22 days'),
  (c49, uid, 'Ingrid Bergström', 'https://linkedin.com/in/ingrid-bergstrom-demo', 'Head of Sustainability', 'Nordic Harvest Foods', 'SENT', 'PAIN_POINT',
   'Hi Ingrid, Nordic food companies face increasing regulatory pressure on waste. Our AI forecasting helps you hit sustainability targets with data.',
   now() - interval '21 days'),
  (c50, uid, 'Samuel Adebayo', 'https://linkedin.com/in/samuel-adebayo-demo', 'Operations Lead', 'Lagos Bites International', 'SENT', 'PAIN_POINT',
   'Hi Samuel, fast-growing African restaurant chains expanding internationally face complex forecasting across different markets. We can help.',
   now() - interval '20 days'),
  (c51, uid, 'Katherine Wu', 'https://linkedin.com/in/katherine-wu-demo', 'Procurement Director', 'BaoHaus Restaurant Group', 'SENT', 'PAIN_POINT',
   'Hi Katherine, dim sum and bao restaurants have unique prep challenges — small batches, many SKUs, short shelf life. Our AI forecasting was built for this.',
   now() - interval '19 days'),
  (c52, uid, 'Derek Sullivan', 'https://linkedin.com/in/derek-sullivan-demo', 'COO', 'PubGrub Holdings', 'SENT', 'PAIN_POINT',
   'Hi Derek, pub chains deal with unpredictable demand from sports events and weather changes. Our AI factors in these external signals for better forecasting.',
   now() - interval '18 days'),
  (c53, uid, 'Yara Kassem', 'https://linkedin.com/in/yara-kassem-demo', 'VP Operations', 'Levant Fresh Foods', 'SENT', 'PAIN_POINT',
   'Hi Yara, Mediterranean food has high fresh ingredient costs. Over-ordering drives waste, under-ordering loses revenue. Our AI balances both.',
   now() - interval '17 days'),
  (c54, uid, 'Brian Mackenzie', 'https://linkedin.com/in/brian-mackenzie-demo', 'Supply Chain VP', 'Outback Kitchen Co', 'SENT', 'PAIN_POINT',
   'Hi Brian, Australian restaurant groups expanding into Asia face wildly different demand patterns. Our AI adapts forecasting models per market.',
   now() - interval '16 days'),
  (c55, uid, 'Patricia Hernandez', 'https://linkedin.com/in/patricia-hernandez-demo', 'Director of Operations', 'Cantina Moderna', 'SENT', 'PAIN_POINT',
   'Hi Patricia, modern Mexican restaurants with seasonal menus need dynamic forecasting. Our AI updates predictions as your menu rotates.',
   now() - interval '15 days'),
  (c56, uid, 'Andrei Popescu', 'https://linkedin.com/in/andrei-popescu-demo', 'Head of Logistics', 'Bucharest Eats', 'SENT', 'PAIN_POINT',
   'Hi Andrei, Eastern European restaurant chains growing quickly often outpace their procurement systems. Our AI scales forecasting as you expand.',
   now() - interval '14 days'),
  (c57, uid, 'Wendy Chung', 'https://linkedin.com/in/wendy-chung-demo', 'Operations Manager', 'Noodle Street Co', 'SENT', 'PAIN_POINT',
   'Hi Wendy, noodle chains waste heavily on broth and fresh toppings. Our AI forecasting predicts daily volumes with 90%+ accuracy.',
   now() - interval '13 days'),
  (c58, uid, 'Tomas Eriksson', 'https://linkedin.com/in/tomas-eriksson-demo', 'VP Procurement', 'SwedeFoods AB', 'SENT', 'PAIN_POINT',
   'Hi Tomas, Scandinavian food companies face short growing seasons and import dependency. Better demand forecasting reduces both cost and waste.',
   now() - interval '12 days'),
  (c59, uid, 'Aaliyah Jackson', 'https://linkedin.com/in/aaliyah-jackson-demo', 'Supply Chain Lead', 'SoulFood Collective', 'SENT', 'PAIN_POINT',
   'Hi Aaliyah, soul food restaurants with made-from-scratch menus need precise prep forecasting. Our AI learns your location-specific demand patterns.',
   now() - interval '11 days'),
  (c60, uid, 'Martin Schneider', 'https://linkedin.com/in/martin-schneider-demo', 'COO', 'Bratwurst Brothers GmbH', 'SENT', 'PAIN_POINT',
   'Hi Martin, German food hall operators face event-driven demand spikes. Our AI incorporates local events and weather for better prep planning.',
   now() - interval '10 days'),
  (c61, uid, 'Deepa Krishnan', 'https://linkedin.com/in/deepa-krishnan-demo', 'Director of Operations', 'Curry Cloud Kitchens', 'SENT', 'PAIN_POINT',
   'Hi Deepa, cloud kitchens running multiple Indian cuisine brands from one kitchen face complex forecasting. Our AI optimizes across all your brands.',
   now() - interval '9 days'),
  (c62, uid, 'François Petit', 'https://linkedin.com/in/francois-petit-demo', 'Head of Supply Chain', 'Lyon Gastro Group', 'SENT', 'PAIN_POINT',
   'Hi François, French restaurant groups pride themselves on fresh ingredients — but that means waste is expensive. Our AI minimizes it without compromising quality.',
   now() - interval '8 days'),
  (c63, uid, 'Ruth Abrams', 'https://linkedin.com/in/ruth-abrams-demo', 'VP Procurement', 'Kosher Kitchen Network', 'SENT', 'PAIN_POINT',
   'Hi Ruth, kosher restaurants face unique supply constraints that make waste especially costly. Our AI forecasting accounts for dietary prep requirements.',
   now() - interval '7 days'),
  (c64, uid, 'Ibrahim Diallo', 'https://linkedin.com/in/ibrahim-diallo-demo', 'Operations Director', 'Sahel Restaurant Group', 'SENT', 'PAIN_POINT',
   'Hi Ibrahim, West African restaurant chains expanding across Europe face new demand patterns. Our AI learns and adapts as you enter new markets.',
   now() - interval '6 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- CONTACTS — VALIDATION_ASK (20)
-- ============================================================
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c65, uid, 'Stephanie Moore', 'https://linkedin.com/in/stephanie-moore-demo', 'Head of Innovation', 'GreenGrocer Tech', 'SENT', 'VALIDATION_ASK',
   'Hi Stephanie, we''re researching how grocery-tech companies think about demand prediction for perishables. Would love your take — 15 min chat?',
   now() - interval '28 days'),
  (c66, uid, 'Akira Watanabe', 'https://linkedin.com/in/akira-watanabe-demo', 'VP Strategy', 'Tokyo Bowl Holdings', 'SENT', 'VALIDATION_ASK',
   'Hi Akira, we''re validating whether Japanese QSR chains see AI forecasting as a priority. Would value your perspective on the Tokyo market.',
   now() - interval '27 days'),
  (c67, uid, 'Christina Papadopoulos', 'https://linkedin.com/in/christina-papadopoulos-demo', 'Sustainability Lead', 'Olive & Vine Restaurants', 'SENT', 'VALIDATION_ASK',
   'Hi Christina, we''re exploring how Mediterranean restaurant groups approach food waste measurement. Is this a top-3 priority for Olive & Vine?',
   now() - interval '26 days'),
  (c68, uid, 'Nathan Foster', 'https://linkedin.com/in/nathan-foster-demo', 'Director of R&D', 'FreshAI Solutions', 'SENT', 'VALIDATION_ASK',
   'Hi Nathan, we''re building AI demand forecasting for restaurants and want to validate our approach with food-tech R&D leaders. Quick chat?',
   now() - interval '25 days'),
  (c69, uid, 'Lena Müller', 'https://linkedin.com/in/lena-muller-demo', 'Head of Product', 'Berlin FoodTech GmbH', 'SENT', 'VALIDATION_ASK',
   'Hi Lena, curious if Berlin FoodTech has seen demand from restaurant clients for predictive ordering tools. We''re exploring this space.',
   now() - interval '24 days'),
  (c70, uid, 'Rajesh Gupta', 'https://linkedin.com/in/rajesh-gupta-demo', 'VP Innovation', 'Mumbai Meals Platform', 'SENT', 'VALIDATION_ASK',
   'Hi Rajesh, India''s food delivery market is massive — we''re researching whether cloud kitchens there would adopt AI demand forecasting. Thoughts?',
   now() - interval '23 days'),
  (c71, uid, 'Sarah O''Connor', 'https://linkedin.com/in/sarah-oconnor-demo', 'Strategy Director', 'Celtic Kitchen Group', 'SENT', 'VALIDATION_ASK',
   'Hi Sarah, we''re validating whether mid-size restaurant groups in Ireland and UK see waste forecasting as a gap in their current tech stack.',
   now() - interval '22 days'),
  (c72, uid, 'Kim Soo-jin', 'https://linkedin.com/in/kim-soojin-demo', 'Head of Operations Research', 'Seoul Eats Corp', 'SENT', 'VALIDATION_ASK',
   'Hi Soo-jin, Korean restaurant chains are known for operational efficiency. We''re curious if AI demand forecasting is on Seoul Eats'' radar.',
   now() - interval '21 days'),
  (c73, uid, 'Antonio Russo', 'https://linkedin.com/in/antonio-russo-demo', 'Innovation Manager', 'Roma Kitchen Holdings', 'SENT', 'VALIDATION_ASK',
   'Hi Antonio, Italian restaurant groups face high waste on fresh pasta and produce. We''re researching whether AI tools would be adopted — your view?',
   now() - interval '20 days'),
  (c74, uid, 'Jennifer Chang', 'https://linkedin.com/in/jennifer-chang-demo', 'VP Strategy', 'SilkRoad Restaurants', 'SENT', 'VALIDATION_ASK',
   'Hi Jennifer, we''re exploring how pan-Asian restaurant chains manage demand across diverse menus. Would SilkRoad benefit from AI-powered forecasting?',
   now() - interval '19 days'),
  (c75, uid, 'Oscar Lindqvist', 'https://linkedin.com/in/oscar-lindqvist-demo', 'R&D Director', 'Stockholm FoodLab', 'SENT', 'VALIDATION_ASK',
   'Hi Oscar, Stockholm FoodLab is at the forefront of food innovation. We''re validating AI demand forecasting — would love your technical perspective.',
   now() - interval '18 days'),
  (c76, uid, 'Beatriz Costa', 'https://linkedin.com/in/beatriz-costa-demo', 'Head of Strategy', 'São Paulo Bistro Group', 'SENT', 'VALIDATION_ASK',
   'Hi Beatriz, Brazilian restaurant groups operate at massive scale. We''re researching whether AI forecasting fits the Latin American market. Thoughts?',
   now() - interval '17 days'),
  (c77, uid, 'William Drake', 'https://linkedin.com/in/william-drake-demo', 'Innovation Lead', 'FoodForward Labs', 'SENT', 'VALIDATION_ASK',
   'Hi William, FoodForward Labs incubates food-tech startups — curious if you''ve seen demand for AI-powered waste reduction tools from your portfolio.',
   now() - interval '16 days'),
  (c78, uid, 'Mei-Ling Huang', 'https://linkedin.com/in/mei-ling-huang-demo', 'Director of Strategy', 'Taipei Eats Platform', 'SENT', 'VALIDATION_ASK',
   'Hi Mei-Ling, Taiwan''s food platform market is competitive. We''re testing whether AI demand forecasting would differentiate operators. Your take?',
   now() - interval '15 days'),
  (c79, uid, 'Patrick O''Malley', 'https://linkedin.com/in/patrick-omalley-demo', 'VP Research', 'Dublin Food Collective', 'SENT', 'VALIDATION_ASK',
   'Hi Patrick, we''re validating whether food collectives and co-ops would adopt demand forecasting tools. Dublin Food Collective seems like a great test case.',
   now() - interval '14 days'),
  (c80, uid, 'Anastasia Kuznetsova', 'https://linkedin.com/in/anastasia-kuznetsova-demo', 'Innovation Director', 'Moscow Kitchen Tech', 'SENT', 'VALIDATION_ASK',
   'Hi Anastasia, we''re exploring how kitchen tech companies in Eastern Europe think about predictive ordering. Is this a priority for your clients?',
   now() - interval '13 days'),
  (c81, uid, 'David Mensah', 'https://linkedin.com/in/david-mensah-demo', 'Strategy Manager', 'Accra Fresh Foods', 'SENT', 'VALIDATION_ASK',
   'Hi David, African food companies are growing rapidly. We''re validating if AI demand forecasting resonates in the West African market.',
   now() - interval '12 days'),
  (c82, uid, 'Hannah Schmidt', 'https://linkedin.com/in/hannah-schmidt-demo', 'Head of R&D', 'Vienna Culinary Group', 'SENT', 'VALIDATION_ASK',
   'Hi Hannah, Austrian restaurant groups blend tradition with efficiency. We''re curious if AI forecasting tools would be welcomed or seen as too disruptive.',
   now() - interval '11 days'),
  (c83, uid, 'Ricardo Flores', 'https://linkedin.com/in/ricardo-flores-demo', 'VP Innovation', 'Mexico City Cocina', 'SENT', 'VALIDATION_ASK',
   'Hi Ricardo, Mexico City''s restaurant scene is booming. We''re researching whether AI-based demand tools would help operators manage waste at scale.',
   now() - interval '10 days'),
  (c84, uid, 'Zara Ahmed', 'https://linkedin.com/in/zara-ahmed-demo', 'Strategy Lead', 'Karachi Kitchen Co', 'SENT', 'VALIDATION_ASK',
   'Hi Zara, South Asian food companies face unique supply chain challenges. We''re validating whether AI forecasting could be impactful here.',
   now() - interval '9 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- CONTACTS — DIRECT_PITCH (15)
-- ============================================================
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c85, uid, 'Vincent Tan', 'https://linkedin.com/in/vincent-tan-demo', 'COO', 'Singapore Hawker Holdings', 'SENT', 'DIRECT_PITCH',
   'Hi Vincent, our AI tool predicts daily demand per dish with 92% accuracy. For hawker-scale operations, that means 25-30% less waste. Quick demo?',
   now() - interval '26 days'),
  (c86, uid, 'Margaret O''Neill', 'https://linkedin.com/in/margaret-oneill-demo', 'VP Operations', 'Dublin Dining Group', 'SENT', 'DIRECT_PITCH',
   'Hi Margaret, we''ve built AI forecasting that reduces restaurant food waste by 30%. Dublin Dining''s 50-location scale makes this especially impactful.',
   now() - interval '25 days'),
  (c87, uid, 'Hiroshi Yamada', 'https://linkedin.com/in/hiroshi-yamada-demo', 'CEO', 'Ramen Republic Japan', 'SENT', 'DIRECT_PITCH',
   'Hi Hiroshi, ramen restaurants waste heavily on broth and char siu prep. Our AI tells you exactly how much to prepare each day. Interested in a demo?',
   now() - interval '24 days'),
  (c88, uid, 'Emma Larsen', 'https://linkedin.com/in/emma-larsen-demo', 'Operations Director', 'Copenhagen Eats', 'SENT', 'DIRECT_PITCH',
   'Hi Emma, our tool helped a Nordic restaurant chain cut waste by 28% in 3 months. Copenhagen Eats'' sustainability focus makes this a natural fit.',
   now() - interval '23 days'),
  (c89, uid, 'Chen Wei', 'https://linkedin.com/in/chen-wei-demo', 'Head of Supply Chain', 'Shanghai Kitchen Corp', 'SENT', 'DIRECT_PITCH',
   'Hi Wei, our AI demand forecasting reduces food waste by 30% for restaurant chains. With Shanghai Kitchen''s 200 locations, the savings are massive.',
   now() - interval '22 days'),
  (c90, uid, 'Alberto Colombo', 'https://linkedin.com/in/alberto-colombo-demo', 'COO', 'Milan Trattoria Group', 'SENT', 'DIRECT_PITCH',
   'Hi Alberto, Italian fresh ingredients are expensive to waste. Our AI forecasting helps trattoria groups predict exactly what they''ll sell each day.',
   now() - interval '20 days'),
  (c91, uid, 'Fatou Diop', 'https://linkedin.com/in/fatou-diop-demo', 'Operations VP', 'Dakar Cuisine International', 'SENT', 'DIRECT_PITCH',
   'Hi Fatou, our AI tool is purpose-built for growing restaurant chains. Dakar Cuisine''s international expansion would benefit from smarter forecasting.',
   now() - interval '18 days'),
  (c92, uid, 'Lucas Almeida', 'https://linkedin.com/in/lucas-almeida-demo', 'Director of Logistics', 'Rio Restaurantes', 'SENT', 'DIRECT_PITCH',
   'Hi Lucas, we''ve built AI that predicts restaurant demand and reduces waste by 30%. Rio Restaurantes'' scale across Brazil makes this high-impact.',
   now() - interval '16 days'),
  (c93, uid, 'Eva Horváth', 'https://linkedin.com/in/eva-horvath-demo', 'Head of Operations', 'Budapest Kitchen Chain', 'SENT', 'DIRECT_PITCH',
   'Hi Eva, our AI forecasting tool cuts food waste by 25-30%. Budapest Kitchen''s rapid growth is the perfect time to implement smarter procurement.',
   now() - interval '15 days'),
  (c94, uid, 'Jason Peters', 'https://linkedin.com/in/jason-peters-demo', 'COO', 'Midwest Diner Holdings', 'SENT', 'DIRECT_PITCH',
   'Hi Jason, diner chains deal with broad menus and variable demand. Our AI learns per-location patterns and predicts daily prep needs accurately.',
   now() - interval '14 days'),
  (c95, uid, 'Sunita Rao', 'https://linkedin.com/in/sunita-rao-demo', 'VP Operations', 'Bangalore Bites Cloud Kitchen', 'SENT', 'DIRECT_PITCH',
   'Hi Sunita, our AI tool is built for cloud kitchens — predicting demand across multiple brands from a single kitchen. Quick demo?',
   now() - interval '12 days'),
  (c96, uid, 'Thomas Weber', 'https://linkedin.com/in/thomas-weber-demo', 'Operations Director', 'Zurich Gastro AG', 'SENT', 'DIRECT_PITCH',
   'Hi Thomas, Swiss restaurant groups face high ingredient costs. Our AI forecasting helps you order precisely what you''ll sell. 30% waste reduction.',
   now() - interval '10 days'),
  (c97, uid, 'Olga Fedorova', 'https://linkedin.com/in/olga-fedorova-demo', 'Head of Procurement', 'St Petersburg Foods', 'SENT', 'DIRECT_PITCH',
   'Hi Olga, our demand forecasting AI reduces restaurant waste by 30%. St Petersburg Foods'' growth trajectory makes this the right time to implement.',
   now() - interval '8 days'),
  (c98, uid, 'Ahmed Mansour', 'https://linkedin.com/in/ahmed-mansour-demo', 'COO', 'Cairo Kitchen Empire', 'SENT', 'DIRECT_PITCH',
   'Hi Ahmed, we help restaurant chains predict daily demand with 92% accuracy. Cairo Kitchen''s 80 locations would see significant waste savings.',
   now() - interval '7 days'),
  (c99, uid, 'Rosa Martinez', 'https://linkedin.com/in/rosa-martinez-demo', 'VP Supply Chain', 'Barcelona Tapas Group', 'SENT', 'DIRECT_PITCH',
   'Hi Rosa, tapas restaurants prep many small dishes — forecasting each one is hard. Our AI handles multi-SKU prediction at scale.',
   now() - interval '6 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- CONTACTS — MUTUAL_CONNECTION (10)
-- ============================================================
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c100, uid, 'Leo Nakamura', 'https://linkedin.com/in/leo-nakamura-demo', 'Director of Strategy', 'Osaka Dining Collective', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Leo, Kenji from FoodTech Asia mentioned you''re rethinking procurement strategy at Osaka Dining. We''re building AI forecasting that might help.',
   now() - interval '26 days'),
  (c101, uid, 'Amanda Chen', 'https://linkedin.com/in/amanda-chen-demo', 'VP Innovation', 'HongKong Eats Platform', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Amanda, our mutual friend at Y Combinator said HongKong Eats is exploring AI for operations. We should connect.',
   now() - interval '24 days'),
  (c102, uid, 'Pierre Moreau', 'https://linkedin.com/in/pierre-moreau-demo', 'Head of Operations', 'Paris Boulangerie Chain', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Pierre, Sophie from the Paris FoodTech meetup suggested I reach out. Our AI demand forecasting could help with bakery waste — a notoriously hard problem.',
   now() - interval '22 days'),
  (c103, uid, 'Siya Naidoo', 'https://linkedin.com/in/siya-naidoo-demo', 'Strategy Director', 'Cape Town Kitchen Co', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Siya, Thabo from Endeavor SA mentioned you''re exploring tech solutions for Cape Town Kitchen. Our AI forecasting might be relevant.',
   now() - interval '20 days'),
  (c104, uid, 'Giulia Ferrari', 'https://linkedin.com/in/giulia-ferrari-demo', 'VP Operations', 'Naples Pizza Corporation', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Giulia, Marco from the Italian FoodTech Association said Naples Pizza is modernizing operations. Our AI forecasting could be a great fit.',
   now() - interval '18 days'),
  (c105, uid, 'Hans Becker', 'https://linkedin.com/in/hans-becker-demo', 'Director of Procurement', 'Hamburg Fish Market', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Hans, a mutual connection from the Hamburg Chamber of Commerce mentioned your seafood waste challenges. We might have a solution.',
   now() - interval '16 days'),
  (c106, uid, 'Tomoko Sato', 'https://linkedin.com/in/tomoko-sato-demo', 'Operations Lead', 'Kyoto Fresh Foods', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Tomoko, Yuki from our first seed batch recommended I connect with you about Kyoto Fresh''s waste reduction goals.',
   now() - interval '14 days'),
  (c107, uid, 'Nicholas Costa', 'https://linkedin.com/in/nicholas-costa-demo', 'Head of Strategy', 'Lisbon Seafood Group', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Nicholas, Ana from Web Summit introduced us virtually. She said Lisbon Seafood is struggling with perishable waste — we can help.',
   now() - interval '12 days'),
  (c108, uid, 'Anika Jansen', 'https://linkedin.com/in/anika-jansen-demo', 'VP Innovation', 'Amsterdam Food Lab', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Anika, Lars from TechStars Amsterdam said we should chat — Amsterdam Food Lab''s mission aligns perfectly with our AI forecasting tool.',
   now() - interval '10 days'),
  (c109, uid, 'Roberto Silva', 'https://linkedin.com/in/roberto-silva-demo', 'COO', 'Buenos Aires Asado Chain', 'SENT', 'MUTUAL_CONNECTION',
   'Hi Roberto, Diego from the LatAm FoodTech network mentioned Buenos Aires Asado is scaling and could use better demand forecasting.',
   now() - interval '8 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- CONTACTS — INDUSTRY_TREND (6)
-- ============================================================
INSERT INTO contacts (id, user_id, full_name, linkedin_url, raw_role, company_name, status, strategy_tag, draft_message, created_at) VALUES
  (c110, uid, 'Freya Nilsson', 'https://linkedin.com/in/freya-nilsson-demo', 'Innovation Director', 'Oslo FoodTech', 'SENT', 'INDUSTRY_TREND',
   'Hi Freya, the Nordic food-tech scene is leading the sustainability charge. Curious how Oslo FoodTech views the shift toward predictive analytics.',
   now() - interval '24 days'),
  (c111, uid, 'Marco Bianchi', 'https://linkedin.com/in/marco-bianchi-demo', 'CTO', 'Venice Kitchen AI', 'SENT', 'INDUSTRY_TREND',
   'Hi Marco, restaurant AI is moving beyond chatbots to operational intelligence. As a CTO in this space, where do you see demand forecasting heading?',
   now() - interval '22 days'),
  (c112, uid, 'Yoon-ji Park', 'https://linkedin.com/in/yoonji-park-demo', 'Head of Strategy', 'Busan Fresh Platform', 'SENT', 'INDUSTRY_TREND',
   'Hi Yoon-ji, Korean food platforms are at the cutting edge of food-tech. The shift toward AI-driven supply chain management seems inevitable.',
   now() - interval '18 days'),
  (c113, uid, 'Maxwell Brown', 'https://linkedin.com/in/maxwell-brown-demo', 'VP Innovation', 'London Restaurant Tech', 'SENT', 'INDUSTRY_TREND',
   'Hi Maxwell, the UK restaurant industry is embracing tech faster than ever. Curious how London Restaurant Tech sees the demand forecasting trend.',
   now() - interval '15 days'),
  (c114, uid, 'Camille Dubois', 'https://linkedin.com/in/camille-dubois-demo', 'Strategy Lead', 'Brussels Kitchen Group', 'SENT', 'INDUSTRY_TREND',
   'Hi Camille, EU food waste legislation is driving a tech adoption wave. How is Brussels Kitchen Group preparing for the 2028 targets?',
   now() - interval '12 days'),
  (c115, uid, 'Arjun Mehta', 'https://linkedin.com/in/arjun-mehta-demo', 'CTO', 'Delhi Food Logistics', 'SENT', 'INDUSTRY_TREND',
   'Hi Arjun, India''s food logistics sector is ripe for AI disruption. The trend toward predictive supply chains could transform the market.',
   now() - interval '9 days')
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- RESEARCH (75 — one per new contact)
-- ============================================================

-- PAIN_POINT research
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c41, 'Golden Wok Restaurants opened 20 new locations in the Southeast US, making it the fastest-growing Asian casual chain.', 'Scaling procurement across diverse Asian menus; wok cooking demands fresh-cut ingredients with hours-long shelf life; regional taste differences.', 'https://restaurantbusinessonline.com/demo/golden-wok', now() - interval '27 days'),
  (gen_random_uuid(), c42, 'Sakura Dining Group reported $3M in annual fish waste due to overestimated omakase demand at their 30 sushi locations.', 'Premium fish waste is extremely expensive; omakase prep requires day-of forecasting; seasonal fish availability adds complexity.', 'https://japantimes.com/demo/sakura-waste', now() - interval '26 days'),
  (gen_random_uuid(), c43, 'EuroFresh Distribution expanded cold chain network to cover 12 European countries, handling 500 tonnes of perishables daily.', 'Cross-border demand variability; cold chain integrity during transit; 24-48hr shelf life on key products.', 'https://foodlogistics.com/demo/eurofresh', now() - interval '26 days'),
  (gen_random_uuid(), c44, 'SaladWorks Express launched a subscription meal plan but saw 35% higher waste than projected in the first quarter.', 'Subscription demand volatility; fresh produce prep waste compounds daily; seasonal ingredient availability.', 'https://fastcasual.com/demo/saladworks-sub', now() - interval '25 days'),
  (gen_random_uuid(), c45, 'AfroSpice Kitchen raised a $5M Series A to expand from 8 to 30 locations across the UK and Netherlands.', 'Rapid scaling with limited ops infrastructure; ethnic ingredient sourcing inconsistency; training new staff on portioning.', 'https://sifted.eu/demo/afrospice-funding', now() - interval '24 days'),
  (gen_random_uuid(), c46, 'ScandiCater AB won the contract for all IKEA corporate events in Scandinavia, requiring 40% capacity increase.', 'Event catering demand is inherently spiky; IKEA sustainability requirements are strict; Nordic seasonal menu changes.', 'https://scandibusiness.com/demo/scandicater-ikea', now() - interval '23 days'),
  (gen_random_uuid(), c47, 'Pho Republic Chain hit 60 locations and is struggling with consistent broth quality and quantity across outlets.', 'Broth requires 12-hour prep cycles; over-production means waste, under-production means lost sales; herb freshness is critical.', 'https://eater.com/demo/pho-republic', now() - interval '22 days'),
  (gen_random_uuid(), c48, 'TacoFiesta Corp launched breakfast tacos at all 100 locations but saw 45% waste in the first two weeks of launch.', 'New daypart demand is unpredictable; breakfast ingredients differ from lunch/dinner; prep timing is compressed.', 'https://qsrmagazine.com/demo/tacofiesta-breakfast', now() - interval '21 days'),
  (gen_random_uuid(), c49, 'Nordic Harvest Foods committed to zero food waste by 2027, setting one of the most aggressive targets in the industry.', 'Aggressive timeline requires tech solutions; current manual processes won''t scale; need real-time forecasting.', 'https://greenbiz.com/demo/nordic-harvest-zero', now() - interval '20 days'),
  (gen_random_uuid(), c50, 'Lagos Bites International opened first US locations in Houston and Atlanta, entering the American market.', 'New market demand patterns are unknown; ingredient sourcing differs from West Africa; cultural adaptation of menu.', 'https://africanbusiness.com/demo/lagos-bites-us', now() - interval '19 days'),
  (gen_random_uuid(), c51, 'BaoHaus Restaurant Group reported that dim sum waste accounts for 22% of food costs due to the variety of small dishes.', 'Steam table items have 30-minute quality windows; morning vs afternoon demand differs drastically; weekend spikes.', 'https://eater.com/demo/baohaus-waste', now() - interval '18 days'),
  (gen_random_uuid(), c52, 'PubGrub Holdings saw 40% demand spikes during World Cup matches, overwhelming their standard prep processes.', 'Event-driven demand is unpredictable; beer and food pairing specials create complex dependencies; staffing compounds the issue.', 'https://morningadvertiser.co.uk/demo/pubgrub-worldcup', now() - interval '17 days'),
  (gen_random_uuid(), c53, 'Levant Fresh Foods expanded their mezze range to 40 items, increasing SKU complexity and waste across locations.', 'Wide mezze variety means many small-batch preps; hummus and dips have 2-day shelf life; catering orders add variability.', 'https://foodnavigator.com/demo/levant-mezze', now() - interval '16 days'),
  (gen_random_uuid(), c54, 'Outback Kitchen Co entered the Singapore market with 5 locations but faced 30% higher waste than Australian operations.', 'Tropical climate affects ingredient shelf life; Asian consumer preferences differ; supply chain is less mature.', 'https://afr.com/demo/outback-singapore', now() - interval '15 days'),
  (gen_random_uuid(), c55, 'Cantina Moderna switched to a seasonal menu rotating every 6 weeks, creating recurring forecasting challenges.', 'Menu rotation resets demand history; seasonal ingredients have variable availability; customer adaptation period.', 'https://mexicodaily.com/demo/cantina-seasonal', now() - interval '14 days'),
  (gen_random_uuid(), c56, 'Bucharest Eats raised $8M to expand from Romania into Poland and Czech Republic with 25 new locations planned.', 'Multi-country expansion requires different demand models; procurement across borders; Eastern European food preferences vary.', 'https://emerging-europe.com/demo/bucharest-eats', now() - interval '13 days'),
  (gen_random_uuid(), c57, 'Noodle Street Co launched delivery-only kitchens in 10 cities, seeing 3x demand variability vs dine-in locations.', 'Delivery demand is weather and platform-algorithm dependent; batch cooking for delivery has different timing; packaging waste adds up.', 'https://restaurantdive.com/demo/noodle-delivery', now() - interval '12 days'),
  (gen_random_uuid(), c58, 'SwedeFoods AB is piloting farm-to-restaurant direct sourcing, requiring more precise demand signals for farmers.', 'Direct sourcing means no buffer inventory; farmers need 3-5 day advance orders; waste is now shared cost with producers.', 'https://nordic-foodtech.com/demo/swedefoods-farm', now() - interval '11 days'),
  (gen_random_uuid(), c59, 'SoulFood Collective opened a commissary kitchen serving 12 locations, centralizing prep but increasing complexity.', 'Central kitchen serves diverse locations; transport adds shelf life pressure; batch production requires aggregate forecasting.', 'https://blackenterprise.com/demo/soulfood-commissary', now() - interval '10 days'),
  (gen_random_uuid(), c60, 'Bratwurst Brothers GmbH saw waste spike 50% at their Oktoberfest locations despite planning for high demand.', 'Festival demand exceeds even optimistic forecasts; weather changes attendance dramatically; post-event waste is massive.', 'https://handelsblatt.com/demo/bratwurst-oktoberfest', now() - interval '9 days'),
  (gen_random_uuid(), c61, 'Curry Cloud Kitchens operates 6 Indian cuisine brands from 3 shared kitchens, with ingredient overlap of 60%.', 'Shared ingredients across brands create complex forecasting dependencies; spice prep is time-intensive; curry base shelf life varies.', 'https://yourstory.com/demo/curry-cloud', now() - interval '8 days'),
  (gen_random_uuid(), c62, 'Lyon Gastro Group was fined €200K under new French anti-waste legislation for food disposal practices.', 'Regulatory fines make waste reduction urgent; French law requires food donation before disposal; compliance tracking is manual.', 'https://lefigaro.fr/demo/lyon-gastro-fine', now() - interval '7 days'),
  (gen_random_uuid(), c63, 'Kosher Kitchen Network struggles with unique supply constraints — kosher-certified ingredients cost 2-3x standard.', 'Premium ingredient costs make waste doubly expensive; kosher prep rules add time constraints; smaller supplier pool limits flexibility.', 'https://jewishchronicle.com/demo/kosher-waste', now() - interval '6 days'),
  (gen_random_uuid(), c64, 'Sahel Restaurant Group expanded to Paris and London, bringing West African cuisine to European markets.', 'West African ingredients must be imported; shelf life is shorter than local alternatives; demand patterns in Europe are unknown.', 'https://africanews.com/demo/sahel-europe', now() - interval '5 days')
ON CONFLICT (contact_id) DO NOTHING;

-- VALIDATION_ASK research
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c65, 'GreenGrocer Tech raised $15M to build a B2B platform connecting sustainable farms directly to grocery chains.', 'Farm-to-store demand signals are weak; seasonal produce forecasting is guesswork; grocery chains want fresher produce with less waste.', 'https://techcrunch.com/demo/greengrocer-raise', now() - interval '27 days'),
  (gen_random_uuid(), c66, 'Tokyo Bowl Holdings opened 10 locations in the US, adapting Japanese bowl concepts for the American market.', 'Cross-cultural menu demand is unpredictable; rice and protein portions differ by market; supply chain for Japanese ingredients in US is complex.', 'https://nikkei.com/demo/tokyo-bowl-us', now() - interval '26 days'),
  (gen_random_uuid(), c67, 'Olive & Vine Restaurants published a sustainability report showing 14% food waste reduction through manual tracking.', 'Manual tracking is labor-intensive and error-prone; want to automate but concerned about integration; need ROI data to justify investment.', 'https://olivevine.com/demo/sustainability-report', now() - interval '25 days'),
  (gen_random_uuid(), c68, 'FreshAI Solutions pivoted from retail AI to restaurant AI, citing larger market opportunity in food waste.', 'Exploring the restaurant waste space; looking for complementary technologies; validating which restaurant segments are most receptive.', 'https://venturebeat.com/demo/freshai-pivot', now() - interval '24 days'),
  (gen_random_uuid(), c69, 'Berlin FoodTech GmbH runs an accelerator that graduated 12 food-tech startups this year, focused on sustainability.', 'Seeing demand from restaurant clients for predictive tools; evaluating which approaches have product-market fit; German market is regulation-driven.', 'https://eu-startups.com/demo/berlin-foodtech', now() - interval '23 days'),
  (gen_random_uuid(), c70, 'Mumbai Meals Platform processes 100K orders daily across 500 cloud kitchens in India.', 'Massive scale makes even 1% waste reduction significant; Indian market is price-sensitive; monsoon season disrupts supply chains.', 'https://economictimes.com/demo/mumbai-meals', now() - interval '22 days'),
  (gen_random_uuid(), c71, 'Celtic Kitchen Group is evaluating tech solutions after manual waste tracking showed inconsistent results across 25 pubs.', 'Staff compliance with waste tracking varies; need automated solution; ROI must be proven within 6 months for board approval.', 'https://irishtimes.com/demo/celtic-kitchen-tech', now() - interval '21 days'),
  (gen_random_uuid(), c72, 'Seoul Eats Corp invested $5M in operational analytics but hasn''t yet addressed demand forecasting.', 'Analytics stack is strong but backward-looking; predictive capabilities are the next priority; Korean market values tech-forward operations.', 'https://koreaherald.com/demo/seoul-eats-analytics', now() - interval '20 days'),
  (gen_random_uuid(), c73, 'Roma Kitchen Holdings is modernizing 80 traditional Italian restaurants with POS and inventory management systems.', 'Digital transformation is underway; restaurants are ready for next-gen tools; traditional chefs resist data-driven prep decisions.', 'https://corriere.it/demo/roma-kitchen-digital', now() - interval '19 days'),
  (gen_random_uuid(), c74, 'SilkRoad Restaurants launched a pan-Asian concept with 15 cuisines under one roof, requiring complex inventory management.', 'Multi-cuisine inventory is exponentially complex; ingredient overlap helps but must be tracked carefully; demand per cuisine varies by location.', 'https://eater.com/demo/silkroad-concept', now() - interval '18 days'),
  (gen_random_uuid(), c75, 'Stockholm FoodLab published research on AI applications in Nordic food production, citing demand forecasting as top use case.', 'Research validates the opportunity; now seeking practical implementations to test; willing to co-develop with startups.', 'https://kth.se/demo/foodlab-ai-research', now() - interval '17 days'),
  (gen_random_uuid(), c76, 'São Paulo Bistro Group operates 120 restaurants across Brazil, facing massive regional demand differences.', 'Brazil is a continent-sized market; regional preferences vary enormously; economic volatility affects dining frequency.', 'https://valoreconomico.com/demo/sp-bistro', now() - interval '16 days'),
  (gen_random_uuid(), c77, 'FoodForward Labs'' portfolio companies collectively raised $80M last year, with waste reduction being the top thesis.', 'Portfolio companies need demand forecasting tools; willing to facilitate intros; interested in platform plays vs point solutions.', 'https://crunchbase.com/demo/foodforward-portfolio', now() - interval '15 days'),
  (gen_random_uuid(), c78, 'Taipei Eats Platform connects 2,000 restaurants to delivery services and is exploring value-added analytics for partners.', 'Platform has order data that could improve forecasting; restaurants lack individual analytics capability; aggregated insights could be a differentiator.', 'https://techinasia.com/demo/taipei-eats-analytics', now() - interval '14 days'),
  (gen_random_uuid(), c79, 'Dublin Food Collective is a co-op of 30 independent restaurants sharing procurement to reduce costs and waste.', 'Collective buying requires collective forecasting; independent restaurants have different demand patterns; seasonal Irish produce adds complexity.', 'https://irishexaminer.com/demo/dublin-collective', now() - interval '13 days'),
  (gen_random_uuid(), c80, 'Moscow Kitchen Tech provides POS systems to 3,000 Russian restaurants and is exploring AI add-on features.', 'Existing POS infrastructure could integrate forecasting; Russian restaurant market is price-sensitive; need to prove ROI at lower price points.', 'https://rbcgroup.com/demo/moscow-kitchen-pos', now() - interval '12 days'),
  (gen_random_uuid(), c81, 'Accra Fresh Foods is building Ghana''s first cold chain network for restaurant supply, addressing a major infrastructure gap.', 'Cold chain is foundational but forecasting is the next layer; West African restaurant market is growing 15% YoY; limited existing data for training.', 'https://africanbusiness.com/demo/accra-coldchain', now() - interval '11 days'),
  (gen_random_uuid(), c82, 'Vienna Culinary Group blends traditional Austrian cuisine with modern efficiency, operating 35 restaurants across Austria.', 'Traditional recipes have variable yields; Austrian market values quality over efficiency; need tools that don''t disrupt established workflows.', 'https://derstandard.at/demo/vienna-culinary', now() - interval '10 days'),
  (gen_random_uuid(), c83, 'Mexico City Cocina operates 45 restaurants and is exploring tech solutions for their high-volume, high-waste operations.', 'Mexican cuisine prep is labor-intensive; salsas and tortillas have short shelf life; market volatility affects ingredient costs.', 'https://expansion.mx/demo/mxcity-cocina', now() - interval '9 days'),
  (gen_random_uuid(), c84, 'Karachi Kitchen Co is Pakistan''s fastest-growing restaurant chain with 25 locations and plans for 100 by 2027.', 'Hyper-growth outpacing operational capabilities; Pakistani food supply chain is fragmented; need scalable tech solutions.', 'https://dawn.com/demo/karachi-kitchen-growth', now() - interval '8 days')
ON CONFLICT (contact_id) DO NOTHING;

-- DIRECT_PITCH research
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c85, 'Singapore Hawker Holdings is modernizing 50 hawker stalls with centralized procurement and inventory management.', 'Hawker stalls have tiny margins; waste on fresh ingredients kills profitability; centralized ordering needs demand signals per stall.', 'https://straitstimes.com/demo/hawker-modernize', now() - interval '25 days'),
  (gen_random_uuid(), c86, 'Dublin Dining Group invested €5M in kitchen automation, reducing labor costs but not yet tackling food waste.', 'Automation handles prep but not planning; food waste is now the top cost reduction opportunity; Irish food regulations are tightening.', 'https://irishtimes.com/demo/dublin-dining-automation', now() - interval '24 days'),
  (gen_random_uuid(), c87, 'Ramen Republic Japan is the third-largest ramen chain globally with 300 locations across 8 countries.', 'Scale means massive waste impact; broth prep is the biggest waste driver; consistency across countries requires standardized forecasting.', 'https://japantimes.com/demo/ramen-republic-global', now() - interval '23 days'),
  (gen_random_uuid(), c88, 'Copenhagen Eats won Denmark''s Green Restaurant Award for their zero-waste kitchen initiatives.', 'Already committed to waste reduction; current methods are manual and labor-intensive; need tech to sustain progress at scale.', 'https://politiken.dk/demo/copenhagen-eats-green', now() - interval '22 days'),
  (gen_random_uuid(), c89, 'Shanghai Kitchen Corp operates 200 restaurants and reported a ¥50M annual loss attributable to food waste.', 'Massive waste cost; Chinese cuisine has high ingredient variety; regional demand differences across China are extreme.', 'https://scmp.com/demo/shanghai-kitchen-waste', now() - interval '21 days'),
  (gen_random_uuid(), c90, 'Milan Trattoria Group sources high-quality Italian ingredients with short shelf lives and premium prices.', 'Fresh mozzarella, basil, and seafood waste is expensive; Italian dining culture demands quality over efficiency; weekend vs weekday demand differs greatly.', 'https://corriere.it/demo/milan-trattoria', now() - interval '19 days'),
  (gen_random_uuid(), c91, 'Dakar Cuisine International brought Senegalese food to 15 cities worldwide, growing 60% YoY.', 'International expansion means new demand patterns per city; African ingredient sourcing varies by market; growth is outpacing operations team.', 'https://jeuneafrique.com/demo/dakar-cuisine', now() - interval '17 days'),
  (gen_random_uuid(), c92, 'Rio Restaurantes operates 80 churrascarias across Brazil, facing unique all-you-can-eat waste challenges.', 'All-you-can-eat model creates inherent over-production; meat cuts have different waste profiles; weekend vs weekday customer volume varies 3x.', 'https://valoreconomico.com/demo/rio-churrascaria', now() - interval '15 days'),
  (gen_random_uuid(), c93, 'Budapest Kitchen Chain is Hungary''s fastest-growing restaurant group, adding 10 locations per quarter.', 'Rapid growth with limited operational infrastructure; Eastern European supply chains are less predictable; need scalable forecasting.', 'https://hvg.hu/demo/budapest-kitchen-growth', now() - interval '14 days'),
  (gen_random_uuid(), c94, 'Midwest Diner Holdings operates 150 diners with classic American menus and broad ingredient requirements.', 'Broad menus mean hundreds of SKUs; comfort food prep quantities are hard to predict; regional and seasonal demand shifts.', 'https://chicagotribune.com/demo/midwest-diner', now() - interval '13 days'),
  (gen_random_uuid(), c95, 'Bangalore Bites Cloud Kitchen runs 8 virtual brands from 5 kitchens, processing 5,000 orders daily.', 'Multi-brand demand forecasting is complex; delivery platform promotions cause demand spikes; ingredient sharing across brands needs optimization.', 'https://yourstory.com/demo/bangalore-bites', now() - interval '11 days'),
  (gen_random_uuid(), c96, 'Zurich Gastro AG faces Switzerland''s highest ingredient costs in Europe, making waste reduction critical.', 'Swiss ingredient costs are 2x European average; restaurant margins are thin; waste reduction has outsized financial impact.', 'https://nzz.ch/demo/zurich-gastro-costs', now() - interval '9 days'),
  (gen_random_uuid(), c97, 'St Petersburg Foods is expanding despite economic challenges, opening 15 new restaurants in Russian cities.', 'Growth in uncertain economic conditions; need to minimize waste to protect margins; import substitution changes ingredient availability.', 'https://kommersant.ru/demo/spb-foods-expansion', now() - interval '7 days'),
  (gen_random_uuid(), c98, 'Cairo Kitchen Empire operates 80 restaurants across Egypt and is the country''s largest casual dining chain.', 'Egyptian market has high price sensitivity; waste reduction directly affects competitive pricing; hot climate shortens ingredient shelf life.', 'https://dailynewsegypt.com/demo/cairo-kitchen', now() - interval '6 days'),
  (gen_random_uuid(), c99, 'Barcelona Tapas Group runs 40 tapas bars with 60+ small dishes each, creating extreme SKU complexity.', 'Tapas model means dozens of small preps; each dish has different demand patterns; evening vs lunch service differs dramatically.', 'https://lavanguardia.com/demo/barcelona-tapas', now() - interval '5 days')
ON CONFLICT (contact_id) DO NOTHING;

-- MUTUAL_CONNECTION research
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c100, 'Osaka Dining Collective operates 25 premium Japanese restaurants and is investing in operational tech for the first time.', 'Traditional Japanese restaurants resist tech; premium dining waste is extremely costly; seasonal kaiseki menus change frequently.', 'https://nikkei.com/demo/osaka-dining-tech', now() - interval '25 days'),
  (gen_random_uuid(), c101, 'HongKong Eats Platform connects 800 restaurants to delivery services and is adding operational tools.', 'Platform data could power forecasting; restaurants on the platform vary widely in sophistication; need turnkey solutions.', 'https://scmp.com/demo/hk-eats-tools', now() - interval '23 days'),
  (gen_random_uuid(), c102, 'Paris Boulangerie Chain wastes an estimated 15% of daily bread production — standard for the industry but costly.', 'Bread must be baked fresh daily; unsold bread becomes total waste; morning vs afternoon demand patterns are difficult to predict.', 'https://lemonde.fr/demo/paris-boulangerie-waste', now() - interval '21 days'),
  (gen_random_uuid(), c103, 'Cape Town Kitchen Co won best restaurant group in South Africa and is expanding to Johannesburg and Durban.', 'Expansion to new cities means new demand patterns; South African supply chain has unique challenges; need scalable operations from day one.', 'https://timeslive.co.za/demo/capetown-kitchen', now() - interval '19 days'),
  (gen_random_uuid(), c104, 'Naples Pizza Corporation exports Neapolitan pizza worldwide through 60 franchise locations in 15 countries.', 'Franchise consistency requires standardized forecasting; dough prep is time-sensitive; mozzarella di bufala has 48-hour shelf life.', 'https://corriere.it/demo/naples-pizza-global', now() - interval '17 days'),
  (gen_random_uuid(), c105, 'Hamburg Fish Market operates Europe''s largest seafood wholesale and restaurant complex, handling 200 tonnes weekly.', 'Seafood is the most perishable food category; wholesale and restaurant demand are different beasts; daily auctions create price volatility.', 'https://hamburger-abendblatt.de/demo/fish-market', now() - interval '15 days'),
  (gen_random_uuid(), c106, 'Kyoto Fresh Foods supplies traditional kaiseki restaurants with hyper-seasonal Japanese ingredients.', 'Kaiseki is ultra-seasonal with ingredients changing weekly; premium ingredients mean premium waste costs; small batch sizes.', 'https://japantimes.com/demo/kyoto-fresh-kaiseki', now() - interval '13 days'),
  (gen_random_uuid(), c107, 'Lisbon Seafood Group operates 20 seafood restaurants and reported 18% annual increase in waste costs.', 'Seafood waste is the most expensive; Portuguese dining culture demands freshness; tourist seasonality creates wild demand swings.', 'https://publico.pt/demo/lisbon-seafood-waste', now() - interval '11 days'),
  (gen_random_uuid(), c108, 'Amsterdam Food Lab runs food-tech experiments with 50 restaurant partners, testing new operational tools.', 'Living lab model means rapid testing cycles; restaurant partners are pre-qualified and open to innovation; Dutch market values sustainability.', 'https://fd.nl/demo/amsterdam-food-lab', now() - interval '9 days'),
  (gen_random_uuid(), c109, 'Buenos Aires Asado Chain is Argentina''s fastest-growing steakhouse group with 30 locations.', 'Argentine beef prices are volatile; asado prep quantities are hard to predict; weekend gaucho events spike demand unpredictably.', 'https://lanacion.com/demo/ba-asado-growth', now() - interval '7 days')
ON CONFLICT (contact_id) DO NOTHING;

-- INDUSTRY_TREND research
INSERT INTO research (id, contact_id, news_summary, pain_points, source_url, last_updated) VALUES
  (gen_random_uuid(), c110, 'Oslo FoodTech published a whitepaper arguing that predictive analytics will define the next decade of food sustainability.', 'Industry thought leader; sees AI forecasting as inevitable; looking for partners to validate the thesis with real restaurant data.', 'https://oslobors.no/demo/oslo-foodtech-whitepaper', now() - interval '23 days'),
  (gen_random_uuid(), c111, 'Venice Kitchen AI is building computer vision for kitchen operations and considering adding demand forecasting to their roadmap.', 'CV for kitchen monitoring is their core; demand forecasting could complement but isn''t their expertise; potential integration partner.', 'https://wired.it/demo/venice-kitchen-ai', now() - interval '21 days'),
  (gen_random_uuid(), c112, 'Busan Fresh Platform processes 50K daily food orders and published data showing 12% average restaurant waste rate.', 'Platform data reveals the problem''s scale; Korean restaurants are tech-forward; regulatory push for waste reduction is growing.', 'https://koreaherald.com/demo/busan-fresh-data', now() - interval '17 days'),
  (gen_random_uuid(), c113, 'London Restaurant Tech hosted a summit on AI in hospitality, attracting 2,000 operators and 200 tech companies.', 'Market is ripe for AI solutions; operators are actively seeking tools; conference validated strong demand for waste reduction tech.', 'https://ft.com/demo/london-restaurant-summit', now() - interval '14 days'),
  (gen_random_uuid(), c114, 'Brussels Kitchen Group is advising EU policymakers on practical food waste reduction technology standards.', 'Policy influence means they shape market requirements; regulatory expertise could inform product design; potential pilot partner for EU compliance.', 'https://euractiv.com/demo/brussels-kitchen-policy', now() - interval '11 days'),
  (gen_random_uuid(), c115, 'Delhi Food Logistics processes 1M meals daily and estimates 8% loss to waste in their cold chain operations.', 'Massive scale makes even small improvements significant; Indian cold chain infrastructure is improving; demand prediction could reduce losses dramatically.', 'https://livemint.com/demo/delhi-food-logistics', now() - interval '8 days')
ON CONFLICT (contact_id) DO NOTHING;


-- ============================================================
-- OUTREACH ATTEMPTS (75)
-- ============================================================

-- PAIN_POINT: 24 sent → 10 REPLIED, 12 GHOSTED, 2 BOUNCED
-- c41-c50: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c41, 'PAIN_POINT', 'Hi Samantha, multi-location Asian restaurant groups lose up to 18% on ingredient waste due to variable demand. We''re building AI to fix that.', now() - interval '26 days', now() - interval '19 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c42, 'PAIN_POINT', 'Hi Robert, Japanese restaurants waste significantly on fresh fish and produce. Our AI forecasting predicts daily demand per item to cut that waste.', now() - interval '25 days', now() - interval '18 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c43, 'PAIN_POINT', 'Hi Elena, fresh food distributors face a unique pain — forecast wrong and you either waste perishables or lose sales. We''re solving this with AI.', now() - interval '25 days', now() - interval '18 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c44, 'PAIN_POINT', 'Hi Tyler, salad-focused chains have some of the shortest shelf lives in QSR. Our demand forecasting helps chains like yours prep exactly what sells.', now() - interval '24 days', now() - interval '17 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c45, 'PAIN_POINT', 'Hi Amara, ethnic cuisine restaurants often lack the data tools larger chains have. Our AI forecasting levels the playing field on waste reduction.', now() - interval '23 days', now() - interval '16 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c46, 'PAIN_POINT', 'Hi Peter, catering in the Nordics has tight margins and strict sustainability requirements. Our AI tool helps predict event demand more accurately.', now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c47, 'PAIN_POINT', 'Hi Michelle, pho restaurants waste heavily on broth prep and fresh herbs. AI demand forecasting can help Pho Republic prep the right volumes daily.', now() - interval '21 days', now() - interval '14 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c48, 'PAIN_POINT', 'Hi Jorge, fast-casual Mexican chains face high waste on prepped ingredients with short hold times. Our AI predicts demand to cut that waste by 30%.', now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c49, 'PAIN_POINT', 'Hi Ingrid, Nordic food companies face increasing regulatory pressure on waste. Our AI forecasting helps you hit sustainability targets with data.', now() - interval '19 days', now() - interval '12 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c50, 'PAIN_POINT', 'Hi Samuel, fast-growing African restaurant chains expanding internationally face complex forecasting across different markets. We can help.', now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;

-- c51-c62: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c51, 'PAIN_POINT', 'Hi Katherine, dim sum and bao restaurants have unique prep challenges — small batches, many SKUs, short shelf life. Our AI forecasting was built for this.', now() - interval '17 days', now() - interval '10 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c52, 'PAIN_POINT', 'Hi Derek, pub chains deal with unpredictable demand from sports events and weather changes. Our AI factors in these external signals for better forecasting.', now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c53, 'PAIN_POINT', 'Hi Yara, Mediterranean food has high fresh ingredient costs. Over-ordering drives waste, under-ordering loses revenue. Our AI balances both.', now() - interval '15 days', now() - interval '8 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c54, 'PAIN_POINT', 'Hi Brian, Australian restaurant groups expanding into Asia face wildly different demand patterns. Our AI adapts forecasting models per market.', now() - interval '14 days', now() - interval '7 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c55, 'PAIN_POINT', 'Hi Patricia, modern Mexican restaurants with seasonal menus need dynamic forecasting. Our AI updates predictions as your menu rotates.', now() - interval '13 days', now() - interval '6 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c56, 'PAIN_POINT', 'Hi Andrei, Eastern European restaurant chains growing quickly often outpace their procurement systems. Our AI scales forecasting as you expand.', now() - interval '12 days', now() - interval '5 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c57, 'PAIN_POINT', 'Hi Wendy, noodle chains waste heavily on broth and fresh toppings. Our AI forecasting predicts daily volumes with 90%+ accuracy.', now() - interval '11 days', now() - interval '4 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c58, 'PAIN_POINT', 'Hi Tomas, Scandinavian food companies face short growing seasons and import dependency. Better demand forecasting reduces both cost and waste.', now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c59, 'PAIN_POINT', 'Hi Aaliyah, soul food restaurants with made-from-scratch menus need precise prep forecasting. Our AI learns your location-specific demand patterns.', now() - interval '9 days', now() - interval '2 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c60, 'PAIN_POINT', 'Hi Martin, German food hall operators face event-driven demand spikes. Our AI incorporates local events and weather for better prep planning.', now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c61, 'PAIN_POINT', 'Hi Deepa, cloud kitchens running multiple Indian cuisine brands from one kitchen face complex forecasting. Our AI optimizes across all your brands.', now() - interval '7 days', now() - interval '0 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c62, 'PAIN_POINT', 'Hi François, French restaurant groups pride themselves on fresh ingredients — but that means waste is expensive. Our AI minimizes it.', now() - interval '6 days', now() - interval '0 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- c63-c64: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c63, 'PAIN_POINT', 'Hi Ruth, kosher restaurants face unique supply constraints that make waste especially costly. Our AI forecasting accounts for dietary prep requirements.', now() - interval '5 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED'),
  (gen_random_uuid(), c64, 'PAIN_POINT', 'Hi Ibrahim, West African restaurant chains expanding across Europe face new demand patterns. Our AI learns and adapts as you enter new markets.', now() - interval '4 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- VALIDATION_ASK: 20 sent → 7 REPLIED, 11 GHOSTED, 2 BOUNCED
-- c65-c71: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c65, 'VALIDATION_ASK', 'Hi Stephanie, we''re researching how grocery-tech companies think about demand prediction for perishables. Would love your take — 15 min chat?', now() - interval '26 days', now() - interval '19 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c66, 'VALIDATION_ASK', 'Hi Akira, we''re validating whether Japanese QSR chains see AI forecasting as a priority. Would value your perspective on the Tokyo market.', now() - interval '25 days', now() - interval '18 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c67, 'VALIDATION_ASK', 'Hi Christina, we''re exploring how Mediterranean restaurant groups approach food waste measurement. Is this a top-3 priority for Olive & Vine?', now() - interval '24 days', now() - interval '17 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c68, 'VALIDATION_ASK', 'Hi Nathan, we''re building AI demand forecasting for restaurants and want to validate our approach with food-tech R&D leaders. Quick chat?', now() - interval '23 days', now() - interval '16 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c69, 'VALIDATION_ASK', 'Hi Lena, curious if Berlin FoodTech has seen demand from restaurant clients for predictive ordering tools. We''re exploring this space.', now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c70, 'VALIDATION_ASK', 'Hi Rajesh, India''s food delivery market is massive — we''re researching whether cloud kitchens there would adopt AI demand forecasting. Thoughts?', now() - interval '21 days', now() - interval '14 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c71, 'VALIDATION_ASK', 'Hi Sarah, we''re validating whether mid-size restaurant groups in Ireland and UK see waste forecasting as a gap in their current tech stack.', now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;

-- c72-c82: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c72, 'VALIDATION_ASK', 'Hi Soo-jin, Korean restaurant chains are known for operational efficiency. We''re curious if AI demand forecasting is on Seoul Eats'' radar.', now() - interval '19 days', now() - interval '12 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c73, 'VALIDATION_ASK', 'Hi Antonio, Italian restaurant groups face high waste on fresh pasta and produce. We''re researching whether AI tools would be adopted — your view?', now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c74, 'VALIDATION_ASK', 'Hi Jennifer, we''re exploring how pan-Asian restaurant chains manage demand across diverse menus. Would SilkRoad benefit from AI-powered forecasting?', now() - interval '17 days', now() - interval '10 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c75, 'VALIDATION_ASK', 'Hi Oscar, Stockholm FoodLab is at the forefront of food innovation. We''re validating AI demand forecasting — would love your technical perspective.', now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c76, 'VALIDATION_ASK', 'Hi Beatriz, Brazilian restaurant groups operate at massive scale. We''re researching whether AI forecasting fits the Latin American market. Thoughts?', now() - interval '15 days', now() - interval '8 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c77, 'VALIDATION_ASK', 'Hi William, FoodForward Labs incubates food-tech startups — curious if you''ve seen demand for AI-powered waste reduction tools from your portfolio.', now() - interval '14 days', now() - interval '7 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c78, 'VALIDATION_ASK', 'Hi Mei-Ling, Taiwan''s food platform market is competitive. We''re testing whether AI demand forecasting would differentiate operators. Your take?', now() - interval '13 days', now() - interval '6 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c79, 'VALIDATION_ASK', 'Hi Patrick, we''re validating whether food collectives and co-ops would adopt demand forecasting tools. Dublin Food Collective seems like a great test case.', now() - interval '12 days', now() - interval '5 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c80, 'VALIDATION_ASK', 'Hi Anastasia, we''re exploring how kitchen tech companies in Eastern Europe think about predictive ordering. Is this a priority for your clients?', now() - interval '11 days', now() - interval '4 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c81, 'VALIDATION_ASK', 'Hi David, African food companies are growing rapidly. We''re validating if AI demand forecasting resonates in the West African market.', now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c82, 'VALIDATION_ASK', 'Hi Hannah, Austrian restaurant groups blend tradition with efficiency. We''re curious if AI forecasting tools would be welcomed or seen as too disruptive.', now() - interval '9 days', now() - interval '2 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- c83-c84: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c83, 'VALIDATION_ASK', 'Hi Ricardo, Mexico City''s restaurant scene is booming. We''re researching whether AI-based demand tools would help operators manage waste at scale.', now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'BOUNCED'),
  (gen_random_uuid(), c84, 'VALIDATION_ASK', 'Hi Zara, South Asian food companies face unique supply chain challenges. We''re validating whether AI forecasting could be impactful here.', now() - interval '7 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- DIRECT_PITCH: 15 sent → 2 REPLIED, 11 GHOSTED, 2 BOUNCED
-- c85-c86: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c85, 'DIRECT_PITCH', 'Hi Vincent, our AI tool predicts daily demand per dish with 92% accuracy. For hawker-scale operations, that means 25-30% less waste. Quick demo?', now() - interval '24 days', now() - interval '17 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c86, 'DIRECT_PITCH', 'Hi Margaret, we''ve built AI forecasting that reduces restaurant food waste by 30%. Dublin Dining''s 50-location scale makes this especially impactful.', now() - interval '23 days', now() - interval '16 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;

-- c87-c97: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c87, 'DIRECT_PITCH', 'Hi Hiroshi, ramen restaurants waste heavily on broth and char siu prep. Our AI tells you exactly how much to prepare each day. Interested in a demo?', now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c88, 'DIRECT_PITCH', 'Hi Emma, our tool helped a Nordic restaurant chain cut waste by 28% in 3 months. Copenhagen Eats'' sustainability focus makes this a natural fit.', now() - interval '21 days', now() - interval '14 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c89, 'DIRECT_PITCH', 'Hi Wei, our AI demand forecasting reduces food waste by 30% for restaurant chains. With Shanghai Kitchen''s 200 locations, the savings are massive.', now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c90, 'DIRECT_PITCH', 'Hi Alberto, Italian fresh ingredients are expensive to waste. Our AI forecasting helps trattoria groups predict exactly what they''ll sell each day.', now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c91, 'DIRECT_PITCH', 'Hi Fatou, our AI tool is purpose-built for growing restaurant chains. Dakar Cuisine''s international expansion would benefit from smarter forecasting.', now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c92, 'DIRECT_PITCH', 'Hi Lucas, we''ve built AI that predicts restaurant demand and reduces waste by 30%. Rio Restaurantes'' scale across Brazil makes this high-impact.', now() - interval '14 days', now() - interval '7 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c93, 'DIRECT_PITCH', 'Hi Eva, our AI forecasting tool cuts food waste by 25-30%. Budapest Kitchen''s rapid growth is the perfect time to implement smarter procurement.', now() - interval '13 days', now() - interval '6 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c94, 'DIRECT_PITCH', 'Hi Jason, diner chains deal with broad menus and variable demand. Our AI learns per-location patterns and predicts daily prep needs accurately.', now() - interval '12 days', now() - interval '5 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c95, 'DIRECT_PITCH', 'Hi Sunita, our AI tool is built for cloud kitchens — predicting demand across multiple brands from a single kitchen. Quick demo?', now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c96, 'DIRECT_PITCH', 'Hi Thomas, Swiss restaurant groups face high ingredient costs. Our AI forecasting helps you order precisely what you''ll sell. 30% waste reduction.', now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c97, 'DIRECT_PITCH', 'Hi Olga, our demand forecasting AI reduces restaurant waste by 30%. St Petersburg Foods'' growth trajectory makes this the right time to implement.', now() - interval '6 days', now() - interval '0 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- c98-c99: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c98, 'DIRECT_PITCH', 'Hi Ahmed, we help restaurant chains predict daily demand with 92% accuracy. Cairo Kitchen''s 80 locations would see significant waste savings.', now() - interval '5 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED'),
  (gen_random_uuid(), c99, 'DIRECT_PITCH', 'Hi Rosa, tapas restaurants prep many small dishes — forecasting each one is hard. Our AI handles multi-SKU prediction at scale.', now() - interval '4 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- MUTUAL_CONNECTION: 10 sent → 5 REPLIED, 4 GHOSTED, 1 BOUNCED
-- c100-c104: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c100, 'MUTUAL_CONNECTION', 'Hi Leo, Kenji from FoodTech Asia mentioned you''re rethinking procurement strategy at Osaka Dining. We''re building AI forecasting that might help.', now() - interval '24 days', now() - interval '17 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c101, 'MUTUAL_CONNECTION', 'Hi Amanda, our mutual friend at Y Combinator said HongKong Eats is exploring AI for operations. We should connect.', now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c102, 'MUTUAL_CONNECTION', 'Hi Pierre, Sophie from the Paris FoodTech meetup suggested I reach out. Our AI demand forecasting could help with bakery waste.', now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c103, 'MUTUAL_CONNECTION', 'Hi Siya, Thabo from Endeavor SA mentioned you''re exploring tech solutions for Cape Town Kitchen. Our AI forecasting might be relevant.', now() - interval '18 days', now() - interval '11 days', 'COMPLETED', 'REPLIED'),
  (gen_random_uuid(), c104, 'MUTUAL_CONNECTION', 'Hi Giulia, Marco from the Italian FoodTech Association said Naples Pizza is modernizing operations. Our AI forecasting could be a great fit.', now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;

-- c105-c108: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c105, 'MUTUAL_CONNECTION', 'Hi Hans, a mutual connection from the Hamburg Chamber of Commerce mentioned your seafood waste challenges. We might have a solution.', now() - interval '14 days', now() - interval '7 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c106, 'MUTUAL_CONNECTION', 'Hi Tomoko, Yuki from our first seed batch recommended I connect with you about Kyoto Fresh''s waste reduction goals.', now() - interval '12 days', now() - interval '5 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c107, 'MUTUAL_CONNECTION', 'Hi Nicholas, Ana from Web Summit introduced us virtually. She said Lisbon Seafood is struggling with perishable waste — we can help.', now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c108, 'MUTUAL_CONNECTION', 'Hi Anika, Lars from TechStars Amsterdam said we should chat — Amsterdam Food Lab''s mission aligns perfectly with our AI forecasting tool.', now() - interval '8 days', now() - interval '1 day', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- c109: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c109, 'MUTUAL_CONNECTION', 'Hi Roberto, Diego from the LatAm FoodTech network mentioned Buenos Aires Asado is scaling and could use better demand forecasting.', now() - interval '6 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;

-- INDUSTRY_TREND: 6 sent → 1 REPLIED, 4 GHOSTED, 1 BOUNCED
-- c110: REPLIED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c110, 'INDUSTRY_TREND', 'Hi Freya, the Nordic food-tech scene is leading the sustainability charge. Curious how Oslo FoodTech views the shift toward predictive analytics.', now() - interval '22 days', now() - interval '15 days', 'COMPLETED', 'REPLIED')
ON CONFLICT DO NOTHING;

-- c111-c114: GHOSTED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c111, 'INDUSTRY_TREND', 'Hi Marco, restaurant AI is moving beyond chatbots to operational intelligence. As a CTO in this space, where do you see demand forecasting heading?', now() - interval '20 days', now() - interval '13 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c112, 'INDUSTRY_TREND', 'Hi Yoon-ji, Korean food platforms are at the cutting edge of food-tech. The shift toward AI-driven supply chain management seems inevitable.', now() - interval '16 days', now() - interval '9 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c113, 'INDUSTRY_TREND', 'Hi Maxwell, the UK restaurant industry is embracing tech faster than ever. Curious how London Restaurant Tech sees the demand forecasting trend.', now() - interval '13 days', now() - interval '6 days', 'COMPLETED', 'GHOSTED'),
  (gen_random_uuid(), c114, 'INDUSTRY_TREND', 'Hi Camille, EU food waste legislation is driving a tech adoption wave. How is Brussels Kitchen Group preparing for the 2028 targets?', now() - interval '10 days', now() - interval '3 days', 'COMPLETED', 'GHOSTED')
ON CONFLICT DO NOTHING;

-- c115: BOUNCED
INSERT INTO outreach_attempts (id, contact_id, strategy_tag, message_body, sent_at, feedback_due_at, feedback_status, outcome) VALUES
  (gen_random_uuid(), c115, 'INDUSTRY_TREND', 'Hi Arjun, India''s food logistics sector is ripe for AI disruption. The trend toward predictive supply chains could transform the market.', now() - interval '7 days', now() - interval '0 days', 'COMPLETED', 'BOUNCED')
ON CONFLICT DO NOTHING;


-- ============================================================
-- ENRICHMENT JOB (second batch)
-- ============================================================
INSERT INTO enrichment_jobs (id, user_id, total_contacts, processed_count, failed_count, status, created_at, completed_at) VALUES
  (gen_random_uuid(), uid, 75, 75, 0, 'COMPLETED', now() - interval '14 days', now() - interval '14 days' + interval '8 minutes')
ON CONFLICT DO NOTHING;

END $$;
