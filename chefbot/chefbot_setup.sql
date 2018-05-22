begin;

-- DO NOT DROP BEFORE COPYING INGREDIENTS
-- drop schema chefbot cascade;

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
);

insert into chefbot.ingredients
    (name, unit, category, auto_add)
values
   
   -- TODO: REDO THIS WITH NEW VALUES

commit;
