create schema chefbot;

create table chefbot.ingredients (
    ingredient_id serial primary key,
    name text,
    unit text,
    category text,
    auto_add boolean
);

create table chefbot.recipes (
    recipe_id serial primary key,
    name text,
    ingredient_id int,
    amount numeric
);

create table chefbot.shopping_list (
    ingredient_id int references chefbot.ingredients,
    amount numeric
);

create table chefbot.schedule (
    dow int,
    recipe_id int references chefbot.ingredients
)

insert into chefbot.ingredients
    (name, unit, category, auto_add)
values
    -- PANTRY
    ('pasta (long)', 'boxes', 'pantry', true),
    ('pasta (short)', 'boxes', 'pantry', true),
    ('pasta sauce', 'jars', 'pantry', true),
    ('canned pasta sauce', 'cans', 'pantry', true),
    ('crushed tomatoes', 'cans', 'pantry', true),
    ('whole canned tomatoes', 'cans', 'pantry', true),
    ('diced tomatoes', 'cans', 'pantry', true),
    ('tomato paste', 'cans', 'pantry', true),
    ('quinoa', 'cups', 'pantry', false),
    ('white rice', 'cups', 'pantry', false),
    ('basmati rice', 'cups', 'pantry', false),
    ('brown rice', 'cups', 'pantry', false),
    ('rice pilaf', 'cups', 'pantry', false),
    ('arborio rice', 'cups', 'pantry', false),
    ('cereal', 'boxes', 'pantry', true),
    ('old-fashioned oatmeal', 'cups', 'pantry', false),
    ('steel cut oats', 'cups', 'pantry', false),
    ('peanut butter', 'teaspoons', 'pantry', false),
    ('almond butter', 'teaspoons', 'pantry', false),
    ('honey', 'teaspoons', 'pantry', false),
    ('strawberry jelly', 'teaspoons', 'pantry', false),
    ('grape jelly', 'teaspoons', 'pantry', false),
    ('raspberry jam', 'teaspoons', 'pantry', false),
    ('maple syrup', 'teaspoons', 'pantry', false),
    ('chipotle peppers in adobo', 'cans', 'pantry', true),
    ('shortening', 'cups', 'pantry', false),
    ('vegetable oil', 'cups', 'pantry', false),
    ('olive oil', 'cups', 'pantry', false),
    ('white distilled vinegar', 'teaspoons', 'pantry', false),
    ('white wine vinegar', 'teaspoons', 'pantry', false),
    ('apple cider vinegar', 'teaspoons', 'pantry', false),
    ('red wine vinegar', 'teaspoons', 'pantry', false),
    ('rice wine vinegar', 'teaspoons', 'pantry', false),
    ('evaporated milk', 'teaspoons', 'pantry', true),
    ('sweetened condensed milk', 'teaspoons', 'pantry', true),
    ('cornmeal', 'teaspoons', 'pantry', true),
    ('masa', 'teaspoons', 'pantry', true),
    ('cornstarch', 'teaspoons', 'pantry', false),
    ('dried black beans', 'teaspoons', 'pantry', true),
    ('dried kidney beans', 'teaspoons', 'pantry', true),
    ('chicken stock', 'cartons', 'pantry', true),
    ('beef stock', 'cartons', 'pantry', true),
    ('vegetable stock', 'cartons', 'pantry', true),
    ('chicken broth', 'cartons', 'pantry', true),
    ('beef broth', 'cartons', 'pantry', true),
    ('vegetable broth', 'cartons', 'pantry', true),
    ('salsa', 'teaspoons', 'pantry', true),
    ('tortillas', '', 'pantry', true),
    ('pecans', 'bags', 'pantry', true),
    ('almonds', 'bags', 'pantry', true),
    ('walnuts', 'bags', 'pantry', true),
    ('tortilla chips', 'bags', 'pantry', true),
    ('potato chips', 'bags', 'pantry', true),

    -- CONDIMENTS
    ('ketchup', 'teaspoons', 'condiments', false),
    ('mayonaise', 'teaspoons', 'condiments', false),
    ('yellow mustard', 'teaspoons', 'condiments', false),
    ('dijon mustard', 'teaspoons', 'condiments', false),
    ('barbeque sauce', 'teaspoons', 'condiments', false),
    ('pesto', 'teaspoons', 'condiments', false),
    ('breadcrumbs', 'teaspoons', 'pantry', true),
    ('panko breadcrumbs', 'teaspoons', 'pantry', true),
    ('worcesterschire sauce', 'teaspoons', 'condiments', false),
    ('hot sauce', 'teaspoons', 'condiments', false),

    -- SPICES & SEASONINGS
    ('kosher salt', 'teaspoons', 'spices', false),
    ('pepper', 'teaspoons', 'spices', false),
    ('cinnamon', 'teaspoons', 'spices', false),
    ('nutmeg', 'teaspoons', 'spices', false),
    ('allspice', 'teaspoons', 'spices', false),
    ('ground thyme', 'teaspoons', 'spices', false),
    ('oregano', 'teaspoons', 'spices', false),
    ('parsley', 'teaspoons', 'spices', false),
    ('tumeric', 'teaspoons', 'spices', false),
    ('italian seasoning', 'teaspoons', 'spices', false),
    ('adobo seasoning', 'teaspoons', 'spices', false),
    ('cloves', 'teaspoons', 'spices', false),
    ('vanilla extract', 'teaspoons', 'spices', false),
    ('almond extract', 'teaspoons', 'spices', false),
    ('peppermint extract', 'teaspoons', 'spices', false),

    -- BAKING
    ('all purpose flour', 'cups', 'baking', false),
    ('whole wheat flour', 'cups', 'baking', false),
    ('self-rising flour', 'cups', 'baking', false),
    ('yeast', 'cups', 'baking', true),
    ('sugar', 'cups', 'baking', false),
    ('brown sugar', 'cups', 'baking', false),
    ('powdered sugar', 'cups', 'baking', false),
    ('baking powder', 'teaspoons', 'baking', false),
    ('baking soda', 'teaspoons', 'baking', false),
    ('chocolate chips', 'cups', 'baking', false),
    ('semi-sweet chocolate', 'cups', 'baking', true),
    ('white chocolate', 'cups', 'baking', true),
    ('dark chocolate', 'cups', 'baking', true),
    ('bittersweet chocolate', 'cups', 'baking', true),
    ('unsweetened chocolate', 'cups', 'baking', true),
    ('pie crusts', '', 'baking', true),

    -- PRODUCE
    ('potatoes', '', 'produce', true),
    ('sweet potatoes', '', 'produce', true),
    ('onions', '', 'produce', true),
    ('garlic', '', 'produce', true),
    ('mint', '', 'produce', true),
    ('basil', '', 'produce', true),
    ('lemons', '', 'produce', true),
    ('limes', '', 'produce', true),
    ('apples', '', 'produce', true),
    ('carrots', '', 'produce', true),
    ('green beans', '', 'produce', true),
    ('peas', '', 'produce', true),
    ('sugar snap peas', '', 'produce', true),
    ('spinach', '', 'produce', true),
    ('brussels sprouts', '', 'produce', true),
    ('lima beans', '', 'produce', true),
    ('parsnips', '', 'produce', true),

    -- BAKERY
    ('wheat bread', 'loaves', 'bakery', true),
    ('white bread', 'loaves', 'bakery', true),
    ('baguette', 'loaves', 'bakery', true),
    ('ciabata', 'loaves', 'bakery', true),
    ('italian bread', 'loaves', 'bakery', true),

    -- DAIRY
    ('parmesean', 'cups', 'dairy', true),
    ('mozzarella', 'cups', 'dairy', true),
    ('cheddar', 'cups', 'dairy', true),
    ('mexican cheese', 'cups', 'dairy', true),
    ('feta', 'ounces', 'dairy', true),
    ('brie', 'ounces', 'dairy', true),
    ('cream cheese', 'ounces', 'dairy', true),
    ('butter (salted)', 'tablespoons', 'dairy', false),
    ('butter (unsalted)', 'teaspoons', 'dairy', false),

    -- REFRIGERATED
    ('lemon juice', 'teaspoons', 'refrigerated', false),
    ('lime juice', 'teaspoons', 'refrigerated', false),

    -- FROZEN
    ('ravioli', 'bags', 'frozen', true),
    ('frozen berries', 'bags', 'frozen', true),
    ('frozen peas', 'bags', 'frozen', true),
    ('frozen corn', 'bags', 'frozen', true),
    ('frozen waffles', 'bags', 'frozen', false),
    ('mozzarella sticks', 'bags', 'frozen', true),
    ('bagel bites', 'bags', 'frozen', true),

    -- DELI
    ('american cheese', 'pounds', 'deli', true),
    ('pepper jack cheese', 'pounds', 'deli', true),
    ('deli turkey', 'pounds', 'deli', true),
    ('deli ham', 'pounds', 'deli', true),

    -- MEAT
    ('ground turkey', 'pounds', 'meat', true),
    ('ground chicken', 'pounds', 'meat', true),
    ('ground beef', 'pounds', 'meat', true),
    ('chicken breast', '', 'meat', true),
    ('bacon', 'pounds', 'meat', true),
    ('beef', 'pounds', 'meat', true),
    ('whole chicken', 'pounds', 'meat', true),
    ('italian sausage', 'pounds', 'meat', true),
    ('chorizo', 'pounds', 'meat', true),
    ('breakfast sausage', 'pounds', 'meat', true),
    ('hot dogs', 'pounds', 'meat', false),

    -- OTHER

