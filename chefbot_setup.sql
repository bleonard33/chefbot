create schema chefbot;

create table chefbot.ingredients (
    ingredient_id int primary key,
    name text,
    unit text,
    category text
);

create table chefbot.recipes (
    recipe_id int primary key,
    name text,
    ingredient_id int,
    amount numeric
);

create table chefbot.shopping_list (
    ingredient_id int,
    amount numeric, 
);

create table chefbot.schedule (
    dow int,
    recipe_id int
)
