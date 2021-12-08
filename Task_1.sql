use Publishing;

-- 1. Вывести информацию обо всех книгах, в имени которых больше 4-х слов.
select * from book
where NameBook like '% % % %';

-- 2. Показать количество авторов в базе данных. Результат сохранить в другую таблицу.
create temporary table tmp
select count(*) from author;

select * from tmp;
drop temporary table tmp;

-- 3. Показать среднеарифметическую цену продажи всех книг. Результат сохранить в временную таблицу.
create temporary table tmp
select avg(price) from sales;

select * from tmp;
drop temporary table tmp;

-- 4. Вывести информацию о книгах по «Computer Science» с наибольшим количеством страниц.
select * from book
where pages = (select max(pages)
								from book 
                                join themes ON book.theme_id = themes.id
                                where NameTHeme = 'Computer science');

-- 5. Показать на экран сумму страниц по каждой из тематик, при этом учитывать только книги одной из следующих тематик: «Computer
-- Science», «Science Fiction», «Web Technologies» и с количеством страниц более 300. 
select  Nametheme, sum(pages) from book
join themes ON book.theme_id = themes.id
where pages > 350
group by Nametheme
having NameTheme ='Computer science';

-- 6. Создать временную таблицу, содержащую самую дорогую книгу тематики, например, «Web Technologies».
create temporary table tmp
select NameBook, priceofbook from book
where priceofbook = (select max(priceofbook) from book
											 join themes On book.theme_id = themes.id
                                             where themes.nameTheme = 'Web Development') ;
select * from tmp;
drop temporary table tmp;

-- 7. Создать запрос, который позволяет вывести всю информацию о
-- работе магазинов. Отсортировать выборку по странам в возрастающем и по названиям магазинов в убывающем порядке.
select * from shop
join country on shop.country_id = country.id
order by NameCountry ASC, NameShop DESC;

-- 8. Создать запрос, показывающий самую популярную книгу
select * from BOOK
join sales on book.id = sales.book_id
where quantity = (select max(quantity) from sales);

-- 9. Создать временную таблицу, в которой предоставляется информация об авторах, имена которых начинаются с А или В.
create temporary table tmp
select * from author
where FirstName LIKE 'A%' OR FirstName Like 'B%';

select * from tmp;
drop temporary table tmp;