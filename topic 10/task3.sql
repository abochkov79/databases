# Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use shop

db.shop.insert({cat: 'Процессоры'})
db.shop.insert({cat: 'Материнские платы'})
db.shop.insert({cat: 'Видеокарты'})
db.shop.insert({cat: 'Жесткие диски'})
db.shop.insert({cat: 'Оперативная память'})

db.shop.insert({prod: 'Intel Core i3-8100'})
db.shop.insert({prod: 'Intel Core i5-7400'})
db.shop.insert({prod: 'AMD FX-8320E'})
db.shop.insert({prod: 'AMD FX-8320'})
db.shop.insert({prod: 'ASUS ROG MAXIMUS X HERO'})
db.shop.insert({prod: 'Gigabyte H310M S2H'})
db.shop.insert({prod: 'MSI B250M GAMING PRO'})

