-- Получить список товаров
SELECT * FROM product;


-- Получить список клиентов из черного списка
SELECT * FROM onlinestore.client where InBlackList = 1;


-- Получить список товаров для заказа с id = 1
SELECT RowNumber, name, price, quantity from
orderproductlist join product on Product_idProduct = idProduct where Order_idOrder = 1;


-- Получить список заказов, c фио клиентов, которые оплачены, но ещё не доставлены
select idOrder, Orders.date, Orders.name, Orders.surname, Orderstatus.name, isdelivered, ispaid from
(select * from `order` join client on Client_idClient = idClient) Orders
join orderstatus on OrderStatus_idOrderStatus = idOrderStatus
where (isdelivered is null or isdelivered != 1) and isPaid = 1

