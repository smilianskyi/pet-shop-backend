create sequence cart_seq start with 1 increment by 1;
create sequence category_seq start with 1 increment by 1;
create sequence order_details_seq start with 1 increment by 1;
create sequence order_seq start with 1 increment by 1;
create sequence product_seq start with 1 increment by 1;
create sequence user_seq start with 1 increment by 1;
create table carts
(
    id      bigint not null,
    user_id bigint unique,
    primary key (id)
);
create table carts_products
(
    cart_id    bigint not null,
    product_id bigint not null
);
create table categories
(
    id   bigint not null,
    name varchar(255),
    primary key (id)
);
create table order_details
(
    amount     numeric(38, 2),
    price      numeric(38, 2),
    id         bigint not null,
    order_id   bigint,
    product_id bigint,
    primary key (id)
);
create table orders
(
    sum     numeric(38, 2),
    created timestamp(6),
    id      bigint not null,
    updated timestamp(6),
    user_id bigint,
    status  varchar(255) check (status in ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED', 'PAID', 'CLOSED')),
    primary key (id)
);
create table orders_details
(
    details_id bigint not null unique,
    order_id   bigint not null
);
create table products
(
    price       numeric(38, 2),
    id          bigint not null,
    description varchar(255),
    name        varchar(255),
    primary key (id)
);
create table products_categories
(
    category_id bigint not null,
    product_id  bigint not null
);
create table users
(
    is_deleted boolean not null,
    cart_id    bigint unique,
    id         bigint  not null,
    email      varchar(255),
    name       varchar(255),
    password   varchar(255),
    phone      varchar(255),
    role       varchar(255) check (role in ('USER', 'ADMIN')),
    primary key (id)
);
alter table if exists carts
    add constraint carts_fk_user_id foreign key (user_id) references users;
alter table if exists carts_products
    add constraint arts_products_fk_product_id foreign key (product_id) references products;
alter table if exists carts_products
    add constraint carts_products_fk_cart_id foreign key (cart_id) references carts;
alter table if exists order_details
    add constraint order_details_fk_orser_id foreign key (order_id) references orders;
alter table if exists order_details
    add constraint order_details_fk_product_id foreign key (product_id) references products;
alter table if exists orders
    add constraint orders_fk_user_id foreign key (user_id) references users;
alter table if exists orders_details
    add constraint orders_details_fk_details_id foreign key (details_id) references order_details;
alter table if exists orders_details
    add constraint orders_details_fk_order_id foreign key (order_id) references orders;
alter table if exists products_categories
    add constraint products_categories_category_id foreign key (category_id) references categories;
alter table if exists products_categories
    add constraint products_categories_fk_product_id foreign key (product_id) references products;
alter table if exists users
    add constraint users_fk_cart foreign key (cart_id) references carts;