UNIT_QUERY = 'select distinct unit from chefbot.ingredients'

RESET_LIST = 'truncate chefbot.shopping_list'

RESET_SCHEDULE = 'truncate chefbot.schedule'

CHECK_ITEM_TEXT = '''select
                        ingredient_id,
                        name,
                        unit
                    from chefbot.ingredients
                    where name % '{0}'
                    order by name <-> '{0}'
                    limit 5'''

ADD_TO_LIST = '''update chefbot.shopping_list l
                    set amount = l.amount + {amount}
                    where ingredient_id = {ingredient_id};

                    insert into chefbot.shopping_list
                    (ingredient_id, amount)
                    select {ingredient_id}, {amount}
                    where not exists (
                        select 1 
                        from chefbot.shopping_list 
                        where ingredient_id={ingredient_id});'''
