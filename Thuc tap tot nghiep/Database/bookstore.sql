create database bookstore;
use bookstore;

create table if not exists `account` (
	account_id bigint primary key auto_increment,
    address varchar(255),
    email varchar(255),
    full_name varchar(255),
    image varchar(255),
	`password` varchar(255) not null,
    phone_number varchar(255),
    username varchar(255) not null
);

create table if not exists roles (
	role_id bigint primary key auto_increment,
    role_name varchar(255)
);

create table if not exists account_role (
	account_role_id bigint primary key auto_increment,				
	account_id bigint not null,				
	role_id bigint not null,				
	foreign key (account_id) references `account`(account_id) on update cascade,				
	foreign key (role_id) references roles (role_id) on update cascade	  			
);

create table if not exists category(
  category_id bigint primary key auto_increment,
  category_name varchar(255)
);

create table if not exists author(
  author_id bigint primary key auto_increment,
  author_name varchar(255),
  author_avatar varchar(255)
);

create table if not exists promotion(
	promotion_id bigint primary key auto_increment,		
    promotion_percent double
);

create table if not exists book(
	book_id bigint primary key auto_increment,
	book_code varchar(255),
	book_name varchar(255),
	book_image varchar(255),
	book_content text(8000),
	book_price double,
	book_size varchar(255),
	book_publish_date varchar(255),
	book_quantity int not null,					
	book_category_id bigint,
	book_author_id bigint,
	book_promotion_id bigint default 1,
  foreign key(book_promotion_id) references promotion(promotion_id) on update cascade,
  foreign key(book_category_id) references category(category_id) on update cascade,
  foreign key(book_author_id) references author(author_id) on update cascade
);

create table if not exists shopping_cart (					
	shopping_cart_id bigint primary key auto_increment,	
    total_items int,
    total_price double,
	account_id bigint,												
	foreign key (account_id) references `account`(account_id)
);

create table if not exists cart_item (					
	cart_item_id bigint primary key auto_increment,		
    quantity int,
    total_price double,
    book_id bigint not null,
	shopping_cart_id bigint not null,					
	foreign key(shopping_cart_id) references shopping_cart(shopping_cart_id) on delete cascade,					
	foreign key(book_id) references book(book_id) on update cascade					
);

create table if not exists orders (
	order_id bigint primary key auto_increment,
    delivery_date datetime,
    is_accpet bit(1),
    order_date datetime,
    order_status varchar(255),
    payment_method varchar(255),
    quantity int,
    total_price double,
    account_id bigint,
    foreign key (account_id) references `account`(account_id)
);

create table if not exists order_detail (
	order_detail_id bigint primary key auto_increment,
    quantity int,
    unit_price double,
    book_id bigint,
    order_id bigint,
    foreign key (book_id) references book(book_id),
    foreign key (order_id) references orders(order_id)
);

insert into `account` (address, email, full_name, image, `password`, phone_number, username) 
value ('Đà Nẵng', 'nguyenvana@gmail.com', 'Nguyễn Văn A', 'https://demoda.vn/wp-content/uploads/2022/02/avatar-anime-cute-562x600.jpg', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', '0905111111', 'admin'),
	  ('Hà Nội', 'nguyenvanb@gmail.com', 'Nguyễn Văn B', 'https://demoda.vn/wp-content/uploads/2022/02/avatar-anime-cuc-de-thuong-600x600.jpg', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', '0905222222', 'customer');

insert into roles (role_name) value ('ROLE_ADMIN'),
									('ROLE_USER');

insert into account_role (account_id, role_id) value ('1', '1'),
													 ('2', '2');
    
insert into category (category_name) value ('Văn học'),
										   ('Kinh tế'),
										   ('Thiếu nhi'),
										   ('Kỹ năng sống'),
										   ('Giáo khoa - Giáo trình'),
										   ('Học ngoại ngữ'),
										   ('Tham khảo'),
										   ('Từ điển'),
										   ('Kiến thức tổng hợp'),
										   ('Khoa học - Kỹ thuật'),
										   ('Lịch sử'),
										   ('Điện ảnh - Nhạc - Họa'),
										   ('Truyện tranh - Manga'),
										   ('Tôn giáo - Tâm linh'),
										   ('Văn hóa - Địa lý - Du lịch'),
										   ('Chính Trị - Pháp Lý');

insert into promotion (promotion_percent) value ('0'),       
												('5'),       
												('10'),       
												('15'),       
												('20'),       
												('25'),       
												('50'),       
												('75'),       
												('90');   
      
insert into author (author_name) value ('Valérie Perrin'),      
									   ('Annie Ernaux'),      
									   ('Napoleon Hill'),      
									   ('Phil Town'),      
									   ('Judy Robinett'),      
									   ('Benjamin Graham'),      
									   ('Nhiều tác giả'),      
									   ('Antoine De Saint-Exupéry'),      
									   ('Walter Macken'),      
									   ('Tô Hoài'),      
									   ('Tuệ An'),      
									   ('Tạ Quốc Kế'),      
									   ('Tiểu Dã'),      
									   ('Bộ Giáo Dục Và Đào Tạo'),      
									   ('Hackers'), 
									   ('Osho'),      
									   ('Nguyễn Văn Dân'),      
									   ('GS. Hoàng Phê'),      
									   ('Shozo Shibuya'),      
									   ('Văn Lang Culture Jsc'),      
									   ('Universe'),      
									   ('Tim Marshall'),      
									   ('Ngô Sa Thạch'),      
									   ('Michio Kaku'),      
									   ('Michael Talbot'),     
									   ('Penney Peirce'),      
									   ('Trần Trọng Kim'),   
									   ('Pema Chodron'),      
									   ('Yuval Noah Harari'),      
									   ('E.H. Gombrich'),      
									   ('Mạc Kỳ Doanh'),      
									   ('Kulzsc'),      
									   ('Huỳnh Phạm Hương Trang'),      
									   ('Yasuhisa Hara'), 
									   ('Nguyên Phong'),      
									   ('Phan Kế Bính'),      
									   ('Trần Quang Đức'),      
									   ('Nguyễn Phương Mai'),      
									   ('Lama Anagarika Govinda'),   
									   ('Zbigniew Brzezinski'),      
									   ('Niccolò Machiavelli'),      
									   ('Quốc hội'),      
									   ('James Comey');
    
insert into book (book_code, book_name, book_image, book_content, book_price, book_size, book_publish_date, book_quantity, book_category_id, book_author_id, book_promotion_id) 
value -- ('BOOK-001', 'Hoa Vẫn Nở Mỗi Ngày', '', 'Violette Toussaint sống mà như chết. Người phụ nữ ấy bị mẹ đẻ bỏ rơi ngay khi vừa lọt lòng, tới lượt cô con gái nhỏ mà cô yêu thương nhất lại bỏ cô mà đi trong một tai nạn thảm khốc, rồi cả đến người chồng một ngày kia cũng không còn ở lại bên cô. Cuộc đời của một nhân viên gác chắn nơi ga xép với những chuyến tàu nhỏ mỗi ngày đến rồi đi hay của một người quản trang tại nghĩa trang tỉnh lẻ chuyên đón nhận người chết và chăm sóc các phần mộ tưởng chừng chỉ gắn chặt với mất mát, buồn đau, rồi úa tàn dần theo năm tháng. Nhưng sự sống là mầu nhiệm, hy vọng vẫn còn đó, hạnh phúc lại có dịp được hồi sinh khi hoa kia được thay nước, khi chính con người vẫn tin vào cuộc đời.', '203650', '15.5 x 24 cm', '2020-11-01', 50, '1', '1', '1'),
	  ('BOOK-002', 'Bộ Ba', '', 'Với khả năng nắm bắt những gì sâu thẳm nhất trong cuộc sống, trong Bộ ba, Valérie Perrin sẽ dẫn dắt ta về thời niên thiếu, đắm chìm trong dòng thời gian cứ thế trôi đi và chia cắt các nhân vật. Một câu chuyện hấp dẫn về tình bạn, tình yêu, cuộc sống, cùng những bí ẩn đan xen chưa tìm được lời đáp.', '330000', '15.5 x 24 cm', '2020-11-01', 50, '1', '1', '1'),
	  ('BOOK-003', 'Một người phụ nữ', '', 'Cảm giác của Annie Ernaux khi thực sự nhận ra mẹ mình không còn trên cõi đời. Và bà gắng đi tìm lại những gương mặt khác nhau của người mẹ ấy, một người phụ nữ vốn rất khỏe, xông xáo, cởi mở, qua đời ngày 7 tháng Tư năm 1986, sau một thời gian mắc bệnh Alzeimer. Qua sự tái hiện cuộc đời một nữ công nhân, rồi chủ hàng thực phẩm luôn lo âu về địa vị và học hỏi không ngừng, Annie Ernaux cũng cho ta thấy sự tiến triển cũng như tính hai mặt của những tình cảm mà một người con gái dành cho mẹ: tình yêu, lòng thù ghét, sự âu yếm, cảm giác tội lỗi và cuối cùng là sự gắn bó máu thịt với người đàn bà già cả đã sa sút trí tuệ. Cùng với đó phảng phất những thăng trầm của nước Pháp suốt thế kỷ 20, giống như lời tổng thống Pháp Emmanuel Macron đã phát biểu khi Annie Ernaux trở thành chủ nhân giải Nobel Văn chương 2022.', '51350', '14 x 20.5 cm', '2023-04-01', 50, '1', '2', '1'),
	  ('BOOK-004', 'Hồi Ức Thiếu Nữ', '', 'Như Annie Ernaux từng chia sẻ trong một bài trả lời phỏng vấn với Gallimard, Hồi Ức Thiếu Nữ không phải là tác phẩm mấu chốt trong toàn bộ sự nghiệp sáng tác của bà, mà có lẽ là mấu chốt của những gì khiến người ta phải sợ hãi khi đặt bút viết ra, mà người ta không ngừng thấy rằng thật sự là quá khó và quá nguy hiểm khi đưa chúng lên trang giấy. Bà chủ yếu nhìn nhận những gì mình đã viết như một nỗ lực tìm kiếm và “khai quật” từ quá khứ người thiếu nữ thuở mười tám đôi mươi mà bà từng là, bằng cách tìm lại những niềm tin, việc làm và cử chỉ của cô, “hạnh kiểm” của cô, như cái cách người ta vẫn thường nói vào những năm 50 của thế kỷ 20 ấy để đánh giá và xếp loại các thiếu nữ.', '88000', '14 x 20.5 cm', '2020-11-01', 50, '1', '2', '1'),
	  ('BOOK-005', 'Một chỗ trong đời', '', 'Một người cha không bao giờ bước chân vào viện bảo tàng, chỉ đọc báo địa phương, không dùng gì khác ngoài con dao Opinel của riêng mình để ăn. Một người cha xuất thân nông dân rồi trở thành công nhân và cuối cùng là chủ một tiệm cà phê kiêm cửa hàng tạp phẩm. Một người cha luôn lo lắng bị nhầm “vị trí”. Cũng người cha ấy lấy làm tự hào về cô con gái nhờ được học hành tử tế mà đã đặt chân được vào giới tiểu tư sản. Nhưng đằng sau đó là khoảng cách, là những đớn đau, giằn vặt giữa cha và con.', '44850', '14 x 20,5 cm', '2022-11-01', 50, '1', '2', '1'),
	  ('BOOK-006', 'Sách Nghĩ Giàu Và Làm Giàu', '', 'Tác phẩm này đã giúp tác giả của nó, Napoleon Hill, được tôn vinh bằng danh hiệu “người tạo ra những nhà triệu phú”. Đây cũng là cuốn sách hiếm hoi được đứng trong top của rất nhiều bình chọn theo nhiều tiêu chí khác nhau - bình chọn của độc giả, của giới chuyên môn, của báo chí. Lý do để Think and Grow Rich - Nghĩ giàu và làm giàu có được vinh quang này thật hiển nhiên và dễ hiểu: Bằng việc đọc và áp dụng những phương pháp đơn giản, cô đọng này vào đời sống của mỗi cá nhân mà đã có hàng ngàn người trên thế giới trở thành triệu phú và thành công bền vững.', '74600', '14 x 20.5 cm', '2020-11-01', 50, '2', '3', '1'),
	  ('BOOK-007', 'Think And Grow Rich', '', 'Think and Grow Rich - Nghĩ giàu và Làm giàu có được vinh quang này thật hiển nhiên và dễ hiểu: Bằng việc đọc và áp dụng những phương pháp đơn giản, cô đọng này vào đời sống của mỗi cá nhân mà đã có hàng ngàn người trên thế giới trở thành triệu phú và thành công bền vững. Điều thú vị nhất là các bí quyết này có thể được hiểu và áp dụng bởi bất kỳ một người bình thường nào, hoạt động trong bất cứ lĩnh vực nào. Qua hơn 70 năm tồn tại, những đúc kết về thành công của Napoleon Hill đến nay vẫn không hề bị lỗi thời, ngược lại, thời gian chính là minh chứng sống động cho tính đúng đắn của những bí quyết mà ông chia sẻ.', '100800', '15 x 20.5 cm', '2020-08-01', 50, '2', '3', '1'),
	  ('BOOK-008', 'Payback Time - Ngày Đòi Nợ', '', 'Cuốn sách sẽ hướng dẫn bạn từ cách thức lựa chọn, đánh giá cổ phiếu, cho đến xây dựng cho mình một danh mục các cổ phiếu sẽ mua, mức giá mua–bán nào là hợp lý, cùng với những nguyên tắc mà bạn phải tuân theo… và cứ thực hành như vậy cho tới khi bạn trở nên giàu có.', '2299000', '16 x 24 cm', '2022-06-27', 50, '2', '4', '1'),
	  ('BOOK-009', 'Siêu Cò', '', 'Trong quyển sách Siêu Cò – Cách thức biến quan hệ thành tiền tệ, Judy Robinett người được biết đến với danh hiệu “người phụ nữ với thông tin liên hệ hạng bạch kim” sẽ chia sẻ đến bạn những bí mật Siêu Kết Nối – Xây dựng các mối quan hệ chiến lược, có giá trị cao, giúp bạn thành công nhanh hơn trong kinh doanh.', '249000', '15.5 x 24 cm', '2022-07-10', 50, '2', '5', '1'),
	  ('BOOK-010', 'Nhà Đầu Tư Thông Minh', '', 'Là nhà tư vấn đầu tư vĩ đại nhất của thế kỷ 20, Benjamin Graham đã giảng dạy và truyền cảm hứng cho nhiều người trên khắp thế giới. Triết lý “đầu tư theo giá trị“ của Graham, bảo vệ nhà đầu tư khỏi những sai lầm lớn và dạy anh ta phát triển các chiến lược dài hạn, đã khiến Nhà đầu tư thông minh trở thành cẩm nang của thị trường chứng khoán kể từ lần xuất bản đầu tiên vào năm 1949.', '119400', '15.5 x 24 cm', '2020-11-01', 50, '2', '6', '1'),
	  ('BOOK-011', 'Bản Đồ', '', 'Đến với cuốn Bản đồ khổng lồ (27x37cm) gồm 52 tấm bản đồ đầy màu sắc sống động này, các bạn nhỏ sẽ được thỏa sức khám phá thế giới. Có tất cả 6 tấm bản đồ lục địa và 42 bản đồ quốc gia. Châu u có gì, châu Á nổi tiếng vì điều chi, khí hậu ở châu Phi như thế nào? Tất cả những chi tiết nổi bật của từng vùng miền, từng đất nước, như địa danh, trang phục, ẩm thực, lễ hội tập tục truyền thống, v…v… đều được liệt kê bằng những hình vẽ ngộ nghĩnh đáng yêu. Mỗi bản đồ có thống kê sơ bộ về diện tích, dân số, ngôn ngữ… để các bạn nhỏ nắm được thông tin tổng quát của từng đất nước, châu lục. Mỗi nước đều được phân chia thành các vùng địa lý cụ thể với tên vùng được viết mờ, các thành phố lớn trong từng nước được viết bằng màu đỏ nổi bật với chấm đỏ bên cạnh.', '224250', '27 x 37 cm', '2020-03-02', 50, '3', '7', '1'),
	  ('BOOK-012', 'Hoàng Tử Bé', '', 'Hoàng tử bé được viết ở New York trong những ngày tác giả sống lưu vong và được xuất bản lần đầu tiên tại New York vào năm 1943, rồi đến năm 1946 mới được xuất bản tại Pháp. Không nghi ngờ gì, đây là tác phẩm nổi tiếng nhất, được đọc nhiều nhất và cũng được yêu mến nhất của Saint-Exupéry. Cuốn sách được bình chọn là tác phẩm hay nhất thế kỉ 20 ở Pháp, đồng thời cũng là cuốn sách Pháp được dịch và được đọc nhiều nhất trên thế giới. Với 250 ngôn ngữ dịch khác nhau kể cả phương ngữ cùng hơn 200 triệu bản in trên toàn thế giới, Hoàng tử bé được coi là một trong những tác phẩm bán chạy nhất của nhân loại.', '45000', '15 x 23 cm', '2019-05-01', 50, '3', '8', '1'),
	  ('BOOK-013', 'Bồ Câu Bay Đi Tìm Bà', '', 'Đã bao giờ bạn đọc một cuốn sách phiêu lưu mà ngọt ngào đến thế này chưa? Ngọt từ chú bé mồ côi vẫn còn ở tuổi ham bắn bi, đá bóng mà đã dám ra một quyết định tày trời: bỏ nhà ra đi để bảo vệ người mình yêu thương. Ngọt đến cô em gái nhỏ xinh như búp bê nhưng không ngại ăn đường ngủ phố, trèo núi băng đồng, hết mực tin tưởng người anh không ca thán nửa lời. Ngọt đến cả những người hai anh em chúng gặp trên đường, từ lớn chí bé: mỗi bận ta run lên lo sợ là mỗi bận ta thở phào hân hoan nhận ra người tốt hóa ra ở khắp nơi. Tất nhiên là trừ nhân vật phản diện: ông bố dượng giả tạo quyết tâm lùng kiếm chúng bằng được, chẳng phải yêu thương gì mà chỉ vì muốn giành lại khoản thừa kế kếch xù.', '50050', '14 x 20.5 cm', '2021-10-01', 50, '3', '9', '1'),
	  ('BOOK-014', 'Truyện Cổ Grimm', '', 'Năm 1812, ấn bản đầu tiên của tập truyện “Kinder-und Hausmärchen” (Chuyện kể cho trẻ em và trong gia đình) ra đời tại Berlin, và lập tức gây được tiếng vang trong cộng đồng những nhà nghiên cứu ở Đức. Nhưng hẳn không một học giả nào tại thời điểm đó, hay thậm chí là những tác giả của tập truyện, có thể hình dung được giá trị và sức ảnh hưởng mà tập truyện mang lại trên toàn cầu, trong suốt chiều dài phát triển của lịch sử nhân loại. Đến tận ngày nay, hơn 200 năm sau ngày phát hành ấn bản đầu tiên, tập truyện vẫn được dịch và tái bản thường xuyên ở hàng trăm quốc gia, tiếp tục nuôi dưỡng những tâm hồn trẻ thơ, tưới tắm cho trí tưởng tượng thông qua các câu chuyện kỳ ảo, được gọi chung với cái tên quen thuộc: “Truyện cổ Grimm”.', '435000', '18.5 x 26.5 cm', '2021-03-01', 50, '3', '7', '1'),
	  ('BOOK-015', 'Dế Mèn Phiêu Lưu Ký', '', 'rong hơn nửa thế kỉ kể từ ngày ra mắt bạn đọc lần đầu tiên năm 1941, "Dế Mèn phiêu lưu kí" là một trong những sáng tác tâm đắc nhất của nhà văn Tô Hoài. ', '90000', '18 x 25 cm', '2019-02-25', 50, '3', '10', '1'),
	  ('BOOK-016', 'Thao Túng Tâm Lý', '', '“Thao túng tâm lý” là một dạng của lạm dụng tâm lý. Cũng giống như lạm dụng tâm lý, thao túng tâm lý có thể xuất hiện ở bất kỳ môi trường nào, từ bất cứ đối tượng độc hại nào. Đó có thể là bố mẹ ruột, anh chị em ruột, người yêu, vợ hoặc chồng, sếp hay đồng nghiệp… của bạn. Với tính chất bí hiểm, âm thầm gây hại, thao túng, lạm dụng tâm lý làm tổn thương cảm xúc, lòng tự trọng, cuộc sống của mỗi nạn nhân. Những người từng bị lạm dụng tâm lý thường không thể miêu tả rõ ràng điều gì đã xảy ra với mình. Trong nhiều trường hợp, nạn nhân bị thao túng đến mức tự hỏi có phải họ là người có lỗi, thậm chí họ có phải là người độc hại trong mối quan hệ đó.', '94640', '13 x 20.5 cm', '2022-03-03', 50, '4', '7', '1'),
	  ('BOOK-017', 'Lặng', '', 'Lặng rồi sẽ yên, yên rồi sẽ an. Tại sao lại như vậy, đơn giản vì khi ta ngừng phản ứng, tạm dừng mọi mong ngóng hay toan tính, lúc đó ta sẽ dễ dàng kết nối được với hiện tại, với chính mình, sự thư giãn sẽ đến.', '225000', '15.5 x 24 cm', '2023-05-20', 50, '4', '11', '1'),
	  ('BOOK-018', 'Bình Yên Trong Bão Tố', '', 'Cuốn sách này là tổng hợp 33 câu chuyện về 33 con người khác nhau đến từ mọi miền đất nước cũng như khắp nơi trên thế giới. Mỗi câu chuyện là một cuộc đời, ở đó có những khoảng trời bão giông nhưng cũng có những lúc bình yên lạ thường. Họ đã sống trong bão tố và cũng đã kịp chuyển mình để trở về với sự bình yên chân thật bên trong, cho dù đó vẫn còn là một hành trình dài nhưng cứ đi rồi sẽ tớ. Những con người đó bằng tất cả nghị lực phi thường của mình đã vượt lên số phận, vượt thoát khỏi nghịch cảnh để tìm về với chính mình, tìm về với con đường hạnh phúc chân chính.', '213000', '15.5 x 24 cm', '2022-08-04', 50, '4', '11', '1'),
	  ('BOOK-019', 'Điềm Tĩnh Và Nóng Giận', '', 'Trong cuộc sống thường ngày, chúng ta thường nổi giận vì nhiều nguyên do: công việc không suôn sẻ, chúng ta tức giận; bị người khác hiểu nhầm, chúng ta tức giận; thấy việc chướng tai gai mắt, chúng ta tức giận; không thể chấp nhận được dư luận xã hội, chúng ta tức giận. Thậm chí, chúng ta bực tức, cáu gắt, hờn dỗi, nhỏ nhen, uất ức vì thời tiết xấu, vì tiền lương thấp, vì nhà cửa bừa bộn, vì thái độ của người khác, vì những chuyện không may mà mình gặp phải. Dường như cuộc đời chúng ta là một chuỗi tức giận không hồi kết. Hãy thử tự hỏi bản thân: sau khi tức giận thì phiền não sẽ tan biến ư?', '64320', '14.5 x 20.5 cm', '2021-11-11', 50, '4', '12', '1'),
	  ('BOOK-020', 'Kỷ Luật Tự Giác', '', 'Theodore Roosevelt cũng từng nói: "Có một kiểu phẩm chất có thể giúp chúng ta lột xác tỏa sáng trong cuộc đời bình thường. Phẩm chất đó không phải là tư chất trời cho, không phải nhờ giáo dục, cũng không phải IQ, mà là SỰ TỰ GIÁC". 99% thành công trên thế giới này đều không phải là ngẫu nhiên. Phía sau hào quang luôn là sự kiên trì tự giác không ngừng nghỉ.', '52080', '13 x 20 cm', '2020-11-15', 50, '4', '13', '1'),
	  ('BOOK-021', 'Giáo Trình Chủ Nghĩa Xã Hội Khoa Học', '', 'Giáo trình gồm 7 chương. Ngoài chương nhập môn trình bày sự ra đời, các giai đoạn phát triển của chủ nghĩa xã hội gắn liền với vai trò của C. Mác, Ph. Ăngghen và V.I. Lênin; đối tượng, phương pháp và ý nghĩa việc nghiên cứu, học tập môn Chủ nghĩa xã hội khoa học; các chương còn lại trình bày một cách hệ thống, toàn diện lý luận về chủ nghĩa xã hội và thời kỳ quá độ lên chủ nghĩa xã hội với những đặc trưng bản chất về: Sứ mệnh lịch sử của giai cấp công nhân; Chủ nghĩa xã hội và thời kỳ quá độ lên chủ nghĩa xã hội; Nền dân chủ và Nhà nước xã hội chủ nghĩa; Cơ cấu xã hội - giai cấp và liên minh giai cấp, tầng lớp trong thời kỳ quá độ lên chủ nghĩa xã hội; Vấn đề dân tộc và tôn giáo trong thời kỳ quá độ lên chủ nghĩa xã hội; Vấn đề gia đình trong thời kỳ quá độ lên chủ nghĩa xã hội.', '58000', '15.5 x 24 cm', '2021-07-17', 50, '5', '14', '1'),
	  ('BOOK-022', 'Giáo Trình Tư Tưởng Hồ Chí Minh', '', 'Giáo trình được kết cấu gồm 6 chương, trình bày những vấn đề cơ bản của tư tưởng Hồ Chí Minh. Chương 1 đề cập những vấn đề chung nhất của môn học (khái niệm, đối tượng, phương pháp nghiên cứu và ý nghĩa học tập môn Tư tưởng Hồ Chí Minh); Chương 2 trình bày cơ sở, quá trình hình thành và phát triển tư tưởng Hồ Chí Minh. Các chương còn lại gồm các nội dung: Tư tưởng Hồ Chí Minh về độc lập dân tộc và chủ nghĩa xã hội; Tư tưởng Hồ Chí Minh về Đảng Cộng sản Việt Nam và Nhà nước của nhân dân, do nhân dân, vì nhân dân; Tư tưởng Hồ Chí Minh về đại đoàn kết toàn dân tộc và đoàn kết quốc tế; Tư tưởng Hồ Chí Minh về văn hóa, con người.', '55000', '15.5 x 24 cm', '2021-07-17', 50, '5', '14', '1'),
	  ('BOOK-023', 'Giáo Trình Kinh Tế Chính Trị Mác – Lênin', '', 'Giáo trình trang bị cho sinh viên hệ thống tri thức lý luận cốt lõi của kinh tế chính trị Mác - Lênin trong bối cảnh phát triển mới của Việt Nam và thế giới. Trên cơ sở đó, sinh viên hình thành tư duy lý luận, kỹ năng phân tích, đánh giá và nhận diện bản chất của các quan hệ lợi ích kinh tế trong phát triển kinh tế - xã hội của đất nước và xây dựng trách nhiệm xã hội phù hợp với bản thân; xây dựng lập trường, ý thức hệ tư tưởng Mác - Lênin, hình thành nền tảng lý luận của chủ nghĩa Mác - Lênin để có thể hoạt động tốt trong lĩnh vực nghiên cứu lý luận cũng như tham gia các hoạt động quản lý kinh tế - xã hội. ', '59000', '15.5 x 24 cm', '2021-07-17', 50, '5', '14', '1'),
	  ('BOOK-024', 'Giáo Trình Lịch Sử Đảng Cộng Sản Việt Nam', '', 'Ngoài chương nhập môn, trình bày về đối tượng, chức năng, nhiệm vụ, nội dung và phương pháp nghiên cứu, học tập lịch sử Đảng Cộng sản Việt Nam, giáo trình có kết cấu gồm 03 chương: Chương 1 nêu quá trình Đảng Cộng sản Việt Nam ra đời và lãnh đạo đấu tranh giành chính quyền (1930 - 1945). Chương 2 nêu về quá trình Đảng lãnh đạo hai cuộc kháng chiến chống ngoại xâm, hoàn thành giải phóng dân tộc, thống nhất đất nước (1945 - 1975); Chương 3 nêu quá trình Đảng lãnh đạo cả nước quá độ lên chủ nghĩa xã hội và tiến hành công cuộc đổi mới (từ năm 1975 đến nay).', '84000', '15.5 x 24 cm', '2021-07-17', 50, '5', '14', '1'),
	  ('BOOK-025', 'Giáo Trình Triết Học Mác – Lênin', '', 'Giáo trình được biên soạn theo yêu cầu đổi mới căn bản, toàn diện giáo dục và đào tạo, phù hợp với đối tượng người học, nhằm cung cấp những tri thức hiểu biết có tính nền tảng và hệ thống về triết học Mác - Lênin; xây dựng thế giới quan duy vật và phương pháp luận biện chứng duy vật làm nền tảng lý luận cho việc nhận thức các vấn đề, nội dung của các môn học khác; nhận thức được thực chất giá trị, bản chất khoa học, cách mạng của triết học Mác - Lênin. Đồng thời, giúp cho sinh viên vận dụng tri thức triết học Mác - Lênin, thế giới quan duy vật và phương pháp luận biện chứng duy vật để rèn luyện tư duy, giúp ích trong học tập và cuộc sống.', '78000', '15.5 x 24 cm', '2021-07-17', 50, '5', '14', '1'),
	  ('BOOK-026', '600 Câu Giao Tiếp Tiếng Hoa', '', 'Bộ sách 600 câu giao tiếp tiếng Hoa gồm 3 cuốn với các chủ đề: Công sở, Cuộc sống hàng ngày, Mua sắm và Ăn uống. Nội dung bài học thiết kế phù hợp theo từng chủ đề cụ thể, mỗi câu đều kèm theo phiên âm, dịch nghĩa, từ vựng, thuận tiện cho việc học phát âm và tra cứu ngữ nghĩa. Sách phân biệt rõ sự khác nhau trong cách sử dụng từ ngữ ở Đài Loan và Trung Quốc. Nếu bạn không có thời gian đến lớp mà muốn giao tiếp tốt, thì bộ sách sẽ là trợ thủ đắc lực cho bạn.', '51900', '13.5 x 21 cm', '2021-04-01', 50, '6', '7', '1'),
	  ('BOOK-027', 'Hackers Toeic Vocabulary', '', 'Hackers TOEIC Vocabulary là cuốn sách được thiết kế nhằm giúp người học có thể hoàn thành mục tiêu nhớ và nắm được cách sử dụng của khoảng gần 7600 từ vựng theo các chủ đề khác nhau trong vòng 30 ngày. Ngoài ra, bạn còn được cung cấp những nội dung cần thiết liên quan như: câu hỏi theo định dạng bài thi thật, các xu hướng ra đề của bài thi dạng thức mới. “120 thành ngữ và cụm từ cố định cần biết để chinh phục bài thi TOEIC” ở cuối sách cũng là một nguồn tài liệu quý giá khiến cho các câu hỏi trong bài thi TOEIC không thể làm khó bạn trên con đường chinh phục điểm số mơ ước.', '209000', '16 x 24 cm', '2022-05-05', 50, '6', '15', '1'),
	  ('BOOK-028', 'Hackers IELTS Basic Writing', '', 'Hackers IELTS Writing Basic là cuốn tài liệu tự học hiệu quả cho những ai cần cải thiện kỹ năng viết để chuẩn bị cho kì thi IELTS. Cuốn sách được thiết kế khoa học giúp người học nắm được các cách diễn đạt thường dùng cùng từng dạng bài cụ thể trong mỗi task của bài thi IELTS Writing chỉ trong 4 tuần.', '135400', '16 x 24 cm', '2021-03-01', 50, '6', '15', '1'),
	  ('BOOK-029', 'Hackers IELTS Basic Listening', '', 'Hackers IELTS Listening Basic là cuốn sách rèn luyện kĩ năng Nghe trong bài thi IELTS, được chia thành 4 tuần với mục đích hướng dẫn và luyện tập từng tuần rất rõ ràng', '152800', '16 x 24 cm', '2021-03-15', 50, '6', '15', '1'),
	  ('BOOK-030', 'Hackers IELTS Basic Reading', '', 'Các bạn có thể tự học mọi kiến thức cần thiết để chuẩn bị cho bài thi IELTS READING, từ căn bản đến thực hành, một cách có hệ thống chỉ trong 4 tuần: Week 1 nắm vững kỹ năng đọc hiểu căn bản; Week 2-3 tiếp cận các dạng bài có trong bài thi IELTS READING; cuối cùng, làm quen với đề thi thật qua các bài ở Week 4.', '164000', '16 x 24 cm', '2023-03-02', 50, '6', '15', '1'),
	  ('BOOK-031', 'Trưởng Thành', '', 'Đa số chúng ta đều lớn lên trong một nền văn hóa theo đuổi sự trẻ trung và tìm cách trì hoãn tuổi già bằng mọi giá. Nhưng có bao giờ bạn tự hỏi chúng ta sẽ thế nào nếu thản nhiên đón nhận quá trình lão hóa của mình thay vì tìm cách níu kéo tuổi trẻ? Osho, một trong những bậc thầy tâm linh vĩ đại nhất của thế kỷ 20, giúp chúng ta giải đáp vấn đề này qua cuốn sách Trưởng thành - Chạm Tới Bầu Trời Nội Tâm Của Bạn.', '86800', '14,5 x 20.5 cm', '2022-05-05', 50, '7', '16', '1'),
	  ('BOOK-032', 'Cảm Xúc', '', 'Trong cuốn sách, Osho khẳng định cảm xúc của chúng ta không bất biến, thay vào đó nó liên tục thay đổi. “Đó là lý do ‘cảm xúc’ được gọi là ‘emotion’ trong ngôn ngữ Anh - ‘emotion’ bắt nguồn từ ‘motion’, nghĩa là sự chuyển động. Chúng chuyển động; do đó chúng là “cảm xúc”, Osho diễn giải - Khoảnh khắc này bạn buồn, khoảnh khắc kia bạn vui; bây giờ bạn tức giận, lát sau bạn đầy lòng cảm thông. Lúc này bạn cảm thấy yêu thương, lúc khác bạn lại chìm trong thù hận; buổi sáng thật vui tươi, buổi tối thật ảm đạm. Và cứ như vậy. Đây không thể nào là bản chất của bạn, bởi đằng sau tất cả những thay đổi này phải có một thứ gì đó giống như sợi chỉ đỏ để kết nối mọi mảnh ghép lại với nhau”. Một khi nắm bắt được “sợi chỉ đỏ” đó, bạn sẽ thấu tỏ chính mình và cả những người xung quanh.', '127500', '14.5 x 20.5 cm', '2022-05-05', 50, '7', '16', '1'),
	  ('BOOK-033', 'Yêu Trong Tỉnh Thức', '', 'Những người đói khát trong nhu cầu, những người luôn kỳ vọng ở tình yêu chính là những người đau khổ nhất. Hai kẻ đói khát tìm thấy nhau trong một mối quan hệ yêu đương cùng những kỳ vọng người kia sẽ mang đến cho mình thứ mình cần – về cơ bản sẽ nhanh chóng thất vọng về nhau và cùng mang đến ngục tù khổ đau cho nhau. Trong cuốn sách Yêu, Osho - bậc thầy tâm linh, người được tôn vinh là một trong 1000 người kiến tạo của thế kỷ 20 – đã đưa ra những kiến giải sâu sắc về nhu cầu tâm lý có sức mạnh lớn nhất của nhân loại và “chỉ cho chúng ta cách trải nghiệm tình yêu”.', '114000', '14.5 x 20.5 cm', '2021-01-01', 50, '7', '16', '1'),
	  ('BOOK-034', 'Trò Chuyện Với Vĩ Nhân', '', 'Sách đưa ra nhiều kiến thức về thiền định: lý do ta cần thiền, ý nghĩa của sự sống và cái chết, lợi ích của thiền định đến cơ thể và tâm thức mỗi người, thông qua những lời giảng giải đơn giản với ngôn từ dễ hiểu của Osho về sự bình an, lòng trắc ẩn, sự minh triết, và những câu chuyện thực tế về cuộc đời và hành trình giác ngộ của các vĩ nhân như Bồ Đề Đạt Ma, Phật Thích Ca Mâu Ni, Lão Tử, Socrates', '134300', '14.5 x 20.5 cm', '2020-11-01', 50, '7', '16', '1'),
	  ('BOOK-035', 'Đường Đến Tự Do', '', 'Tự do vốn là thứ mà con người vẫn luôn tìm kiếm từ bao đời nay. Có nhiều định nghĩa về khái niệm tự do, nhưng theo bậc thầy tâm linh Osho, khi được sống đúng với con người mà bạn được sinh ra một cách tự nhiên nhất, không bị tác động bởi một người nào hay bị uốn nắn bởi một tôn giáo nào, bạn đang được tự do một cách toàn vẹn. Đường đến tự do sẽ đầy ắp những câu hỏi cũng như sự hồ nghi, và chỉ khi hiểu được bản thân là ai, tự mình khám phá ra được cách vận hành của thế giới này thì ta mới thật sự chạm đến tự do.', '114000', '14.5 x 20.5 cm', '2022-05-05', 50, '7', '16', '1'),
	  ('BOOK-036', 'Từ Điển Việt Hoa', '', 'Từ Điển Việt Hoa bỏ túi là ấn bản đầy đủ nhất và mới nhất được biên soạn công phu và chi tiết trong dòng từ điển Việt Hoa bỏ túi. Ở lần tái bản này, từ điển được cập nhật nhiều từ vựng thông dụng hiện đại, mang đến cho độc giả phiên bản hoàn chỉnh, đầy đủ nhất.', '64000', '10 x 17 cm', '2022-04-04', 50, '8', '7', '1'),
	  ('BOOK-037', 'Từ Điển Mỹ Học', '', 'Mỹ học là một bộ môn khoa học nằm trong triết học, nó nghiên cứu bản chất, quy luật của cái đẹp trong thiên nhiên, xã hội, con người và nghệ thuật; đồng thời nghiên cứu các nguyên lý, phạm trù của thái độ nhận định và cảm thụ của con người đối với những cái đẹp đó. Về sau nó được mở rộng cho cả nghiên cứu lý thuyết và phê bình văn học nghệ thuật. Chính vì thế mà mỹ học có khi còn tồn tại lẫn trong lý luận về văn học nghệ thuật. Việc nghiên cứu mỹ học cũng vì thế mà có thể nằm trong cả các công trình nghiên cứu lý luận và phê bình văn học nghệ thuật và cả triết học.', '314650', '15.5 x 24 cm', '2022-07-20', 50, '8', '17', '1'),
	  ('BOOK-038', 'Từ Điển Tiếng Việt', '', 'Cuốn sách Từ điển Tiếng Việt (2021) Hoàng Phê của Viện Ngôn ngữ học đã là nguồn tra cứu, trích dẫn đáng tin cậy của hầu hết các bài viết, sách chuyên khảo, đặc biệt là các luận án tiến sĩ, luận văn thạc sĩ, khoá luận tốt nghiệp khi phân tích ý nghĩa của các đơn vị từ ngữ tiếng Việt, là cẩm nang tra cứu không thể thiếu của tất cả những người cầm bút, dù đó là nhà văn, nhà thơ, hay nhà báo, kể cả các nhà giáo giảng dạy tiếng Việt.', '404000', '16 x 24 cm', '2021-11-01', 50, '8', '18', '1'),
	  ('BOOK-039', 'Từ Điển Tâm Lý', '', 'Từ Điển Tâm Lý chính là cuốn sách “vỡ lòng” về tính cách và cảm xúc, giúp bạn trở nên thấu đáo và khéo léo hơn trong giao tiếp. Được tổng hợp và chắt lọc từ khối kiến thức đồ sộ của các chuyên gia tâm lý và viết lại bằng giọng văn thân thiện, Từ Điển Tâm Lý hứa hẹn đem lại cho bạn đọc những kiến thức cơ bản về tính cách và cảm xúc của con người. Cuốn sách không chỉ dừng lai ở lý thuyết suông mà còn đưa ra những giải pháp cụ thể hướng dẫn bạn đọc vận dụng kiến thức về “tính cách” và “cảm xúc”, giúp bạn thấu hiểu bản thân và người khác, từ đó xây dựng những mối quan hệ lành mạnh.', '110500', '14 x 20.5 cm', '2020-11-01', 50, '8', '19', '1'),
	  ('BOOK-040', 'Từ Điển Chính Tả Tiếng Việt', '', 'Cuốn sách từ điển chính tả tiếng Việt bao gồm: Cung cấp cách viết chuẩn mực hiện hành của từng từ ngữ cụ thể, giải thích các nét nghĩa cơ bản của từ một cách ngắn gọn và chuẩn xác, tinh chọn những mục từ phổ biến,nhà sách online dễ sai chính tả nhất, không cần sử dụng thêm từ điển Tiếng Việt khi gặp những từ khó hiểu.', '54400', '10 x 16 cm', '1900-01-16', 50, '8', '20', '1'),
	  ('BOOK-041', 'Chiêm Tinh Học Cơ Bản', '', 'Nếu bạn bắt đầu hứng thú và muốn tìm hiểu về chiêm tinh, thì Chiêm tinh học cơ bản được dành cho bạn. Rất nhiều chiêm tinh gia đã bắt đầu y như cách bạn đang làm bây giờ. Đọc quyển sách này, bạn có thể nắm vững những kiến thức cơ bản về chiêm tinh và có khả năng kiến giải bản đồ sao cá nhân như những chiêm tinh gia chuyên nghiệp. Bạn sẽ được diễn giải từ những nền tảng cơ bản trong chiêm tinh học, 12 Cung hoàng đạo, đến các Hành tinh, Nhà, Góc chiếu và cả Luận giải biểu đồ để tìm hiểu về tình cảm, tiền bạc lẫn thành công trong sự nghiệp. Và dĩ nhiên, với một người chưa bắt đầu, Chiêm tinh học cơ bản cũng sẽ nêu ra những từ vựng chiêm tinh để bạn có thể du hành “vũ trụ” một cách dễ dàng.', '270500', '20.5 x 23.5 cm', '2021-12-01', 50, '9', '7', '1'),
	  ('BOOK-042', 'Vị Thần Của Những Quyết Định', '', 'Một cuốn sách tâm linh giúp bạn giải quyết những vấn đề trong cuộc sống, công việc, tình cảm… Nếu bạn đang phân vân trước những lựa chọn, nếu bạn đang thiếu quyết đoán, nếu bạn không biết tiếp theo nên làm gì: hãy đặt một câu hỏi và hãy để những vị thần quyết định thay bạn.', '52930', '10 x 12 cm', '2022-07-01', 50, '9', '21', '1'),
	  ('BOOK-043', 'Những Tù Nhân Của Địa Lý', '', '“Khi chúng ta đang vươn tới những vì sao, chính bởi những thách thức đặt ra phía trước mà chúng ta có lẽ sẽ phải chung tay để ứng phó: du hành vào vũ trụ không phải với tư cách người Nga, người Trung Quốc hay người Mỹ, mà là những đại diện của nhân loại. Nhưng cho đến nay, mặc dù đã thoát khỏi sự kìm hãm của trọng lực, chúng ta vẫn đang bị giam giữ trong tâm trí của chính mình, bị giới hạn bởi sự nghi ngờ của mình về ‘kẻ khác’, và do đó bởi cuộc cạnh tranh chính yếu về tài nguyên. Phía trước chúng ta còn cả một chặng đường dài.”', '126000', '14 x 20.5 cm', '2020-12-11', 50, '9', '22', '1'),
	  ('BOOK-044', 'Chết cho màu cờ', '', 'Qua chín chương sách, tác giả đã đưa ra được hầu hết những lá cờ điển hình của các cường quốc và những khu vực lớn trên thế giới như: Mỹ, Anh, Liên minh châu Âu, Trung Đông, châu Á, châu Phi, Mỹ Latin và cả những lá cờ của các tổ chức khủng bố. Mỗi lá cờ đều chứa đựng những câu chuyện bí mật, không chỉ về nguồn gốc và ý nghĩa của từng biểu tượng gắn trên chúng còn cả lịch sử lâu dài về tôn giáo và sắc tộc mà có thể lần đầu tiên ta được nghe tới.', '136500', '14 x 20.5 cm', '2020-11-01', 50, '9', '22', '1'),
	  ('BOOK-045', 'Luật Tâm Thức', '', '“Luật Tâm Thức - giải mã ma trận vũ trụ” sẽ giải đáp tất cả những khía cạnh mà có thể bạn không nhận thức được chúng tồn tại, và có thể khám phá những vùng đất mình chưa từng biết đến.', '195640', '18 x 23.5 cm', '2021-05-01', 50, '9', '23', '1'),
	  ('BOOK-046', 'Các Thế Giới Song Song', '', 'Một chuyến du hành đầy trí tuệ qua các vũ trụ, được dẫn dắt tài tình bởi "thuyền trưởng" Michio Kaku và độc giả có dịp chiêm ngưỡng vẻ đẹp kỳ vĩ của vũ trụ kể từ vụ nổ lớn, vượt qua những hố đen, lỗ sâu, bước vào các thế giới lượng tử từ muôn màu kỳ lạ nằm ngay trước mũi chúng ta, vốn dĩ tồn tại song song trên một màng bên ngoài không - thời gian bốn chiều, ngắm nhìn thực tại vật chất quen thuộc hoà quyện với thế giới của những điều kỳ diệu như năng lượng và vật chất tối, sự nảy chồi của các vũ trụ, những chiều không gian bí ẩn và sự biến ảo của các dây rung siêu nhỏ...', '119500', '15 x 24 cm', '2018-03-28', 5, '10', '24', '1'),
	  ('BOOK-047', '50 Thủ Thuật Toán', '', 'Cuốn sách tổng hợp các mẹo tính nhanh, tính nhẩm từ phép cộng, trừ, cho đến nhân, chia hay thậm chí là bình phương, lập phương, khai căn. Bạn sẽ khám phá 50 cách không thể tin được để bạn có thể thao tác với các con số để giải phương trình, các bài toán đố và các bài toán hóc búa trong nháy mắt. Bạn sẽ không còn phải lệ thuộc vào những chiếc máy tính, mà sẽ biến bộ não của mình trở thành một chiếc máy tính thiên tài. ', '113000', '15.5 x 24 cm', '2024-03-11', 50, '10', '7', '1'),
	  ('BOOK-048', 'Vũ Trụ Toàn Ảnh', '', 'Song song với sự phát triển của khoa học, những điều huyền bí vẫn tồn tại bất chấp các định lý, định luật và điều kiện của tự nhiên mà khoa học hiện đại tuân theo. Đối mặt với vấn đề này, hầu hết các nhà khoa học lựa chọn “từ bỏ”, phủ nhận những điều huyền bí, một số người cực đoan thậm chí quy kết tất cả những gì siêu nhiên là mê tín. Mặc dù vậy, vẫn có những người tiếp tục nghiên cứu mặc sự dèm pha của đồng nghiệp. Michael Talbot là một trong số đó. Trong cuốn sách Vũ trụ toàn ảnh, ông đã đề xuất ý tưởng cho rằng toàn bộ vũ trụ là một cơ thể khổng lồ, không thể chia tách, là một ảnh toàn ký mà dù có chia nhỏ đến đâu vẫn cho ra hình ảnh nguyên vẹn. Theo quan niệm này, ông đã giải thích những điều kỳ lạ, những phép lạ tôn giáo, trải nghiệm cận tử, thoát xác, những khả năng phi thường của con người – tiên tri, thấu thị, cơ thể không bị tổn thương, đi trên dung nham nóng chảy, chữa bệnh bằng sức mạnh tinh thần… – bằng nguyên lý toàn ảnh, dựa trên những chứng cứ mà ông thu thập được và chính từ trải nghiệm của bản thân. Qua đó, ông cũng phần nào giải thích vì sao những hiện tượng siêu nhiên hay khả năng đặc biệt phần lớn được những người theo những nền văn hóa cổ trải nghiệm mà không phải những người thông thái theo trường phái hiện đại. Ý thức và niềm tin chính là chìa khóa cho vấn đề này.', '180650', '14.5 x 20.5 cm', '2018-01-03', 50, '10', '25', '1'),
	  ('BOOK-049', 'Blockchain Cơ Bản', '', 'Với 25 bước tiếp cận đơn giản, không công thức toán học, không ngôn ngữ lập trình, và không yêu cầu nền tảng kỹ thuật, Blockchain cơ bản sẽ giải đáp toàn bộ câu hỏi trên thông qua lối trình bày dễ hiểu và gần gũi nhất. Bạn sẽ được chỉ lối để tiến vào cuộc hành trình tìm kiếm tri thức với những hình ảnh trực quan, so sánh tượng trưng và liên hệ thực tế về khái niệm cơ bản, cách hoạt động, cũng như ứng dụng của blockchain trong thời đại công nghệ số.', '165000', '15.5 x 24 cm', '2023-11-24', 50, '10', '7', '1'),
	  ('BOOK-050', 'Tần Số Rung Động', '', 'Có thể chúng ta đã nghe đâu đó rằng đây là thời đại tỉnh thức. Người ta tìm đến thiền định, ăn chay, khai mở luân xa và vô vàn những phương pháp để đạt được sự chữa lành, thức tỉnh, nâng cao tần số rung động. Nhưng cho dù bạn không thực hành bất kỳ nghi thức nào thì sự thức tỉnh vẫn diễn ra, bởi tâm linh thực sự chính là trải nghiệm mỗi sự việc trong đời sống thường sống thường ngày bằng cái tâm cởi mở và trân trọng.', '154000', '15.5 x 24 cm', '2023-10-26', 50, '10', '26', '1'),
	  ('BOOK-051', 'Việt Nam Sử Lược', '', 'Đầu thế kỷ XX, giữa lúc nền học thuật nước nhà chỉ có các bộ đại tác như Đại Việt sử ký toàn thư hay Khâm định Việt sử thông giám cương mục là nguồn sử liệu chính thống nhưng chưa đáp ứng nhu cầu tìm hiểu lịch sử của phần đông dân chúng, thì Việt Nam sử lược, với tư cách là bộ thông sử chi tiết đầu tiên được viết bằng chữ quốc ngữ, đã xuất hiện và nhanh chóng thu hút sự quan tâm của độc giả lẫn giới nghiên cứu cả nước. Từ đó đến nay đã 100 năm trôi qua, tác phẩm vẫn giữ nguyên giá trị và là quyển sách vỡ lòng quen thuộc cho những ai bắt đầu tìm hiểu lịch sử Việt Nam.', '609500', '18.5 x 26.5 cm', '2021-07-15', 50, '11', '27', '1'),
	  ('BOOK-052', 'When things fall apart', '', 'Bước chân vào hành trình tâm linh giống như bước vào một chiếc thuyền rất nhỏ và ra khơi để đi tìm những vùng đất mới. Càng để tâm vào thực hành, chúng ta càng có thêm động lực, nhưng đồng thời trước sau gì, chúng ta cũng phải đối mặt với nỗi sợ. Để chạm đến những cột mốc mới, người ta phải vượt qua những giới hạn cũ, đó là điều tất yếu. Như những nhà thám hiểm của bất kỳ chuyến hành trình nào khác, chúng ta dấn thân khám phá những điều bí ẩn đang chờ đợi phía trước mà không chắc liệu mình có đủ dũng khí đối diện nó hay không.', '109500', '13 x 19 cm', '2021-02-01', 50, '11', '28', '1'),
	  ('BOOK-053', 'Sapiens Lược Sử Loài Người', '', 'Trong ấn bản mới này của cuốn Sapiens - Lược sử loài người, chúng tôi đã có một số hiệu chỉnh về nội dung với sự tham gia, đóng góp của các thành viên Cộng đồng đọc sách Tinh hoa. Xin trân trọng cảm ơn ý kiến đóng góp tận tâm của các quý độc giả, đặc biệt là ông Nguyễn Hoàng Giang, ông Nguyễn Việt Long, ông Đặng Trọng Hiếu cùng những người khác. Mong tiếp tục nhận được sự quan tâm và góp ý từ độc giả.', '251650', '16 x 24 cm', '2021-07-01', 50, '11', '29', '1'),
	  ('BOOK-054', 'Những Cuốn Sách Thay Đổi Lịch Sử', '', '"Trong những trang sách này, chúng ta sẽ tìm thấy nhiều danh tác đã định hình thế giới ta đang sống. Chúng là tiếng nói của sự thông thái và mặc khải, của sự tiến bộ hay thậm chí là hết sức táo bạo, một số tác phẩm có tầm ảnh hưởng vô cùng đáng kinh ngạc, và nhiều tác phẩm vẫn còn truyền cảm hứng cho đến tận ngày nay. Một số tác phẩm đại diện cho những gì tốt nhất của loài người chúng ta, số khác thì không, nhưng tựu trung chúng đều nhắc ta nhớ rằng sách thật sự là người bạn sẽ không bao giờ rời bỏ ta. Đó là lý do tại sao chúng ta trân trọng sách đến thế."', '339500', '25 x 30 cm', '2020-02-02', 50, '11', '7', '1'),
	  ('BOOK-055', 'Lược Sử Thế Giới', '', 'Như một bài thơ về lịch sử thế giới, E. H. Gombrich lịch lãm dẫn người đọc đi từ thời kỳ Đồ đá đến thời kỳ của năng lượng nguyên tử, với những biến cố lịch sử phức tạp nhất, các trào lưu tư tưởng khó hiểu nhất, những nhân vật lịch sử đa chiều nhất, các thành tựu lớn lao nhất của trí tuệ con người… tất cả đều được tác giả mô tả và diễn giải dễ hiểu đến bất ngờ.', '208000', '18.5 x 23.5 cm', '2019-01-10', 50, '11', '30', '1'),
	  ('BOOK-056', 'Khu Vườn Chiêm Tinh', '', 'Cuốn sách không chỉ thể hiện góc nhìn của tác giả Mạc Kỳ Doanh về các cung hoàng đạo mà còn là món quà gửi đến cậu, người đã trải qua một ngày làm việc chăm chỉ. Cậu đã vất vả rồi! Cậu là một đóa hoa độc nhất vô nhị trong khu vườn cuộc sống này. Mong rằng, khi cậu chính tay điểm màu vào những hình vẽ trắng, nỗi buồn nếu có sẽ vơi đi, tâm hồn sẽ được lấp đầy bằng niềm vui kỳ diệu của sắc màu.', '108000', '15.5 x 24 cm', '2020-11-01', 50, '12', '31', '1'),
	  ('BOOK-057', 'Tô Bình Yên Vẽ Hạnh Phúc', '', 'Không giống với những cuốn sách chỉ để đọc, “Tô bình yên – vẽ hạnh phúc” là một cuốn sách mà độc giả vừa tìm được “Hạnh phúc to to từ những điều nho nhỏ” vừa được thực hành ngay lập tức. Một sự kết hợp mới lạ đầy thú vị giữa thể loại sách tản văn và sách tô màu. Lật mở cuốn sách này, bạn sẽ thấy vô vàn những điều nhỏ bé dễ thương lan tòa nguồn năng lượng tích cực. Và kèm theo một list những điều tuyệt vời khiến bạn không thể bỏ lỡ:', '54560', '24 x 19 cm', '2022-02-01', 50, '12', '32', '1'),
	  ('BOOK-058', 'Mình Chỉ Là Người Bình Thường', '', '“Mình chỉ là người bình thường” - muốn trao đi rất nhiều yêu thương  còn là NHẬT KÍ của chính tác giả, ghi lại khoảng thời gian thanh xuân tươi đẹp nhất của Kulzsc. Đẹp bởi những điều tuyệt vời, đẹp bởi những khi may mắn, đẹp bởi cả những lúc khó khăn, đẹp bởi cô đơn, đẹp bởi những rung động thật khẽ…', '124000', '15.5 x 24 cm', '2022-08-24', 50, '12', '32', '1'),
	  ('BOOK-059', 'Bí Quyết Vẽ Bút Chì', '', 'Xuyên suốt các trang sách, Bí quyết vẽ bút chì giới thiệu tới người đọc những nguyên tắc của hình họa (con mắt - Công cụ cơ bản của phối cảnh, các đồ vật hình lập phương, sử dụng các bản phác thảo để hoàn chỉnh một hình vẽ, các đồ vật hình trụ) vẽ phong cảnh bằng bút chì. Hi vọng đây sẽ là một tài liệu hữu ích dành cho các bạn sinh viên đang theo học các ngành thiết kế và hội họa, dùng làm tài liệu tham khảo phục vụ học tập.', '93000', '19 x 27 cm', '2023-04-01', 50, '12', '33', '1'),
	  ('BOOK-060', 'Bí Quyết Vẽ Ký Họa', '', 'Bí Quyết Vẽ Ký Họa (Tái Bản)', '90900', '15.5 x 24 cm', '2020-11-01', 50, '12', '33', '1'),
	  ('BOOK-061', 'Blue Period - Tập 04', '', 'Yataro Yaguchi là một học sinh xuất sắc nhưng có lối sống buông thả, không mục đích. Một ngày nọ, tận mắt chiêm ngưỡng bức tranh của một chị lớp trên ở CLB Mỹ thuật, Yataro hoàn toàn bị hút hồn và lần đầu tiên trong đời, cậu đã tìm ra thứ mình thật sự đam mê và đặt mọi tâm huyết vào đó. Yataro quyết định tham gia vào CLB mỹ thuật và nuôi hy vọng thi vào trường ĐH mỹ thuật Tokyo danh tiếng. Thế nhưng, cậu liên tục vấp phải sự phản đối từ cha mẹ và bạn bè. Đứng trước tình thế khó xử này, Yataro đã quyết định tự mình thuyết phục mọi người bằng các bức vẽ đầy tâm huyết.', '43000', '13 x 19 cm', '2022-08-08', 50 , '13', '34', '1'),
	  ('BOOK-062', 'Kingdom - Tập 34', '', 'Đương sự sẽ được thông báo trước về cái chết của mình vỏn vẹn 24 giờ thông qua một tờ giấy báo tử với tên gọi “Ikigami”. Vậy 24 giờ cuối đời, họ sẽ trải qua như thế nào?', '40700', '15.5 x 24 cm', '2022-11-01', 50, '13', '34', '1'),
	  ('BOOK-063', 'Kingdom - Tập 33', '', 'Đương sự sẽ được thông báo trước về cái chết của mình vỏn vẹn 24 giờ thông qua một tờ giấy báo tử với tên gọi “Ikigami”. Vậy 24 giờ cuối đời, họ sẽ trải qua như thế nào?', '32600', '15.5 x 24 cm', '2022-09-09', 50, '13', '34', '1'),
	  ('BOOK-064', 'Kingdom - Tập 32', '', 'Đương sự sẽ được thông báo trước về cái chết của mình vỏn vẹn 24 giờ thông qua một tờ giấy báo tử với tên gọi “Ikigami”. Vậy 24 giờ cuối đời, họ sẽ trải qua như thế nào?', '32600', '15.5 x 24 cm', '2022-08-08', 50, '13', '34', '1'),
	  ('BOOK-065', 'Kingdom - Tập 31', '', 'Đương sự sẽ được thông báo trước về cái chết của mình vỏn vẹn 24 giờ thông qua một tờ giấy báo tử với tên gọi “Ikigami”. Vậy 24 giờ cuối đời, họ sẽ trải qua như thế nào?', '40700', '15.5 x 24 cm', '2022-08-01', 50, '13', '34', '1'),
	  ('BOOK-066', 'Muôn Kiếp Nhân Sinh', '', '“Muôn kiếp nhân sinh” là tác phẩm do Giáo sư John Vũ - Nguyên Phong viết từ năm 2017 và hoàn tất đầu năm 2020 ghi lại những câu chuyện, trải nghiệm tiền kiếp kỳ lạ từ nhiều kiếp sống của người bạn tâm giao lâu năm, ông Thomas – một nhà kinh doanh tài chính nổi tiếng ở New York. Những câu chuyện chưa từng tiết lộ này sẽ giúp mọi người trên thế giới chiêm nghiệm, khám phá các quy luật về luật Nhân quả và Luân hồi của vũ trụ giữa lúc trái đất đang gặp nhiều tai ương, biến động, khủng hoảng từng ngày.', '163350', '14.5 x 20.5 cm', '2020-11-01', 50, '14', '35', '1'),
	  ('BOOK-067', 'Bên Rặng Tuyết Sơn', '', 'Bên Rặng Tuyết Sơn là quyển sách mới trong bộ sách khoa học tâm linh nổi tiếng của dịch giả Nguyên Phong. Khơi nguồn từ vùng núi Himalaya xa xôi và vùng đồng bằng Ấn Độ, Bên Rặng Tuyết Sơn mang đến cho bạn đọc những sự thật vĩ đại về tâm linh và vai trò của việc làm chủ tâm linh cũng như làm chủ số phận. Tác phẩm còn khơi dậy những giá trị cao đẹp như: Tính trung thực, trái tim bao dung, lòng trắc ẩn, sự thông thái, lòng tín ngưỡng và tình yêu bao la.', '80000', '14.5 x 20.5 cm', '2021-06-12', 50, '14', '35', '1'),
	  ('BOOK-068', 'Trở Về Từ Xứ Tuyết', '', 'Trở về từ xứ tuyết là cuốn sách tiếp theo trong bộ sách về văn hóa, tâm linh của dịch giả Nguyên Phong được First News xuất bản. Sau cuốn sách về cuộc hành trình “Đường mây qua xứ tuyết” các ngài đã được biết Tây Tạng là một xứ nằm ở vị trí hiểm trở, biệt lập với thế giới bên ngoài, nhờ thế nó duy trì được một nền văn minh cổ khác với những nền văn minh mà chúng ta được biết đến. Không một ai đặt chân vào Tây Tạng mà không chịu ảnh hưởng của nó, và không ai có thể chui rúc vào đời sống chật hẹp khi đã nhìn thấy sự bao la hùng vĩ của rặng Tuyết Sơn.', '62400', '14.5 x 20.5 cm', '2021-04-01', 50, '14', '35', '1'),
	  ('BOOK-069', 'Đường Mây Trong Cõi Mộng', '', 'Đường mây trong cõi mộng được GS. John Vu - Nguyên Phong và Hòa thượng Thích Hằng Đạt kỳ công biên tập từ ấn bản tiếng Anh A Buddhist Master In Dreamland của Charles Luk, là bản dịch từ cuốn Hám Sơn Đại sư Mộng du tập và cuốn Chan Master Han Shan’s Autobiography của Lu Kuan Yu (bản dịch từ cuốn Hám Sơn Lão nhân Tự sự Niên phổ), đồng thời khảo cứu nhiều tư liệu lịch sử quan trọng khác về tình hình Phật giáo và triều đại nhà Minh của Trung Quốc.', '100400', '14.5 x 20.5 cm', '2021-08-01', 50, '14', '35', '1'),
	  ('BOOK-070', 'Hoa Trôi Trên Sóng Nước', '', '“Hoa trôi trên sóng nước” là một câu chuyện đặc biệt. Đó là câu chuyện đi tìm “kiến tánh”, đạt được giác ngộ của ni sư Satomi Myodo – một trong những ni sư lỗi lạc nhất của Thiền tông Nhật Bản.', '86000', '14.5 x 20.5 cm', '2022-11-01', 50, '14', '35', '1'),
	  ('BOOK-071', 'Việt Nam Phong Tục', '', '"Việt Nam phong tục” là một nghiên cứu khá kĩ lưỡng, bức tranh toàn diện về phong tục, tập quán của người Việt, từ phong tục trong gia đình, làng xã đến phong tục quốc gia, xã hội được viết với văn phong hiện đại dù vẫn chịu ảnh hưởng của lối viết biền ngẫu đăng đối trong văn học cổ. Mỗi chương, mục đều được tác giả trình bày và diễn giải khúc chiết, ngắn gọn, rõ ràng với quan điểm khá tân tiến so với những người cùng thời.', '133500', '16 x 24 cm', '2017-11-23', 50, '15', '36', '1'),
	  ('BOOK-072', 'Chuyện Trà', '', 'Vẫn nghiêm cẩn, công phu, sắc sảo như trong Ngàn năm áo mũ, nhưng thêm vào đó vẻ phóng khoáng, tươi mới từ những chuyến đi và những trải nghiệm riêng, Trần Quang Đức trở lại để kể về một thức uống có lịch sử lâu đời của người Việt. Trong khoảng thinh không lắng đọng, câu chuyện trà hiện lên qua giọng kể của anh, từ nơi rừng núi bạt ngàn đến chốn phòng văn thanh nhã, từ thuở sơ khai dân dã cho đến hình thái tinh xảo dụng công. Vượt qua tất cả các giới hạn về không gian và thời gian, trà ngày nay vẫn kết nối con người trong một thế giới tinh thần dung dị, khiến những dao động trong lòng ta dần chậm lại, nhịp nhàng hơn, tiến tới một sự cân bằng thật đẹp.', '260500', '17 x 25 cm', '2021-12-01', 50, '15', '37', '1'),
	  ('BOOK-073', 'Ngàn Năm Áo Mũ', '', 'Trang phục cung đình luôn được quy định nghiêm ngặt và có nhiều đổi thay qua các triều đại. Ngàn năm áo mũ lý giải nguyên do và phân tích mức độ mô phỏng trang phục Trung Hoa trong quy chế trang phục của các triều đại Việt Nam, mô tả chi tiết, tỉ mỉ nhiều dạng trang phục như bộ Tế phục Cổn Miện uy nghi của các vị hoàng đế, các bộ Triều phục, Thường phục Lương quan, Củng Thần, Ô Sa, Bổ phục trang trọng của bá quan, hay Lễ phục Vĩ Địch, Phượng quan lộng lẫy của hoàng hậu Trong khi đó trang phục dân gian không biến động nhiều, phổ biến là kiểu áo giao lĩnh, tứ thân, hay lối ăn mặc cởi trần đóng khố của đàn ông và yếm, váy giản tiện của đàn bà tồn tại qua hàng trăm năm lịch sử. Sự kiện vua Minh Mạng cấm “quần không đáy” là một biến cố lớn lao, để rồi chiếc áo dài năm thân đi vào đời sống dân gian và bây giờ trở thành trang phục quan trọng bậc nhất của người Việt.', '258000', '17 x 25 cm', '2021-01-01', 50, '15', '37', '1'),
	  ('BOOK-074', 'Con Đường Hồi Giáo', '', '"Bởi tôi biết còn có rất nhiều điều thiêng liêng hơn niềm tin tôn giáo, ấy là niềm tin vào sự ràng buộc cội rễ của giống loài; vào sự giống nhau giữa người với người hơn là sự khác biệt về đức tin; vào lòng tốt; vào sự đồng cảm và hướng thiện. Tôi tin là một khi đặt chân đến Trung Đông, với trái tim này mở toang không che giấu, những người Hồi rồi cũng sẽ mở lòng với tôi - một cô gái Việt Nam vô thần." - (Nguyễn Phương Mai)', '65000', '14 x 20.5 cm', '2020-03-01', 50, '15', '38', '1'),
	  ('BOOK-075', 'Đường Mây Qua Xứ Tuyết', '', 'Đường Mây Qua Xứ Tuyết (“The Way of the White Clouds”) ghi lại những điều Anagarika Govinda chứng kiến trong thời gian du hành ở Tây Tạng. Hành trình của tác giả diễn ra vào khoảng thập niên 30 đến thập niên 50 của thế kỷtrước, trước thời kỳ diễn biến chính trị phức tạp dẫn đến sự sáp nhập vào lãnh thổ nước Cộng hòa Nhân dân Trung Hoa như hiện nay. Thời điểm đó, một phần phía tây của Tây Tạng bị xem như nằm dưới sự kiểm soát của chính quyền thuộc địa Anh nên việc tác giả đi từ Sri Lanka sang Ấn Độ rồi thâm nhập phía tây Tây Tạng (tất cả đều là thuộc địa của Anh), giấy tờ thông hành đều do người Anh kiểm soát. Về phần sau của hành trình, tác giả đi sâu vào phần phía đông Tây Tạng vốn thuộc sự quản lý của chính quyền Lạt Ma tại Lhasa nên lại phải xin cấp thêm giấy thông hành từ chính quyền này.', '78700', '14.5 x 20.5 cm', '2021-12-01', 50, '15', '39', '1'),
	  ('BOOK-076', 'Bàn Cờ Lớn', '', '“Bàn cờ lớn” thể hiện tầm nhìn địa chiến lược táo bạo và khiêu khích của Brzezinski dành cho sự ưu việt của nước Mỹ trong thế kỷ 21. Điểm trọng tâm trong phân tích của ông là việc thực thi quyền lực trên lục địa Á-Âu, nơi tập trung phần lớn dân số, tài nguyên thiên nhiên và hoạt động kinh tế của toàn cầu. Trải dài từ Bồ Đào Nha đến Eo biển Bering, từ Lapland đến Malaysia, lục địa Á-Âu chính là một bàn cờ vĩ đại, nơi mà quyền lực tối cao của nước Mỹ sẽ được phê chuẩn và thách thức trong một tầm nhìn dài hạn của những năm sau này. Từ đó, nhiệm vụ mà nước Mỹ phải đối mặt là hiểu về những thay đổi địa chính trị mới trong khu vực này, nhằm đề phòng những đối thủ cạnh tranh mới, quản lý các cuộc xung đột và mối quan hệ ở châu Âu, châu Á và Trung Đông sau sự sụp đổ của Liên Xô để không có siêu cường đối thủ nào phát sinh có thể đe dọa lợi ích sống còn, sự thịnh vượng hay sức mạnh toàn cầu dành riêng cho nước Mỹ.', '113000', '15.5 x 24 cm', '2020-11-01', 50, '16', '40', '1'),
	  ('BOOK-077', 'Quân Vương – Thuật Cai Trị', '', 'Cuốn sách bàn về khoa học chính trị của nhà ngoại giao, nhà triết học và nhà quân sự người Ý – Niccolò Machiavelli. Xuất hiện lần đầu tiên vào năm 1513 nhưng mãi đến năm 1532, ấn bản đầu tiên mới được chính thức xuất bản dưới sự cho phép của Giáo hoàng Clement VII.', '72220', '14 x 20.5 cm', '2018-03-03', 50, '16', '41', '1'),
	  ('BOOK-078', 'Bộ Luật Dân Sự', '', 'Bộ luật dân sự bao gồm 689 điều, có những nội dung nổi bật về chuyển đổi giới tính. Thực hiện hợp đồng khi hoàn cảnh thay đổi cơ bản. Các nghĩa vụ tài sản và các khoản chi phí liên quan đến thừa kế. Cuốn sách ra đời nhằm tạo điều kiện thuận tiện cho bạn đọc trong việc tra cứu và áp dụng Pháp luật. Nội dung cuốn sách trình bày đầy đủ các chương và điều trong Bộ luật Dân sự. Đây là tài liệu quan trọng trong hệ thống pháp luật.', '92000', '14.5 x 20.5 cm', '2019-01-01', 50, '16', '42', '1'),
	  ('BOOK-079', 'Hơn cả lòng trung thành', '', 'Hơn cả lòng trung thành là cuốn hồi ký của một nhân vật đặc biệt. Tác giả cuốn sách, James Comey, đứng ở trung tâm các cơn lốc chính trị Hoa Kỳ suốt từ thời Tổng thống Bush, qua thời Tổng thống Obama và kết thúc ở đầu nhiệm kỳ Tổng thống Trump. Là một quan chức cao cấp trong lĩnh vực tư pháp và chấp pháp, với lập trường xuyên suốt là bảo vệ người dân Mỹ, bảo vệ hiến pháp Mỹ, bảo vệ sự chính trực của hệ thống tư pháp, đồng thời luôn đề cao đạo đức của người lãnh đạo, James Comey liên tục va chạm với Nhà Trắng trong những vụ việc cực kỳ sóng gió, trong đó có thể kể đến việc phản đối chính quyền Bush nghe trộm người dân, vụ điều tra Hillary Clinton và vụ điều tra can thiệp của Nga vào bầu cử tổng thống Mỹ.', '113750', '15.5 x 24 cm', '2020-11-01', 50, '16', '43', '1'),
	  ('BOOK-080', 'Luật Cạnh Tranh (Hiện Hành)', '', 'Luật cạnh tranh đã được Quốc hội nước Cộng hòa xã hội chủ nghĩa Việt Nam khóa XIV, kỳ họp thứ 5 thông qua ngày 12 tháng 6 năm 2018 và có hiệu lực thi hành từ ngày 01 tháng 7 năm 2019.', '32000', '15.5 x 24 cm', '2019-07-01', 50, '16', '42', '1');

    
ALTER TABLE book
MODIFY COLUMN book_publish_date varchar(255);

select * from book 
where book_category_id = "1"
order by book_price asc;
    
ALTER TABLE `account` ADD encryted_password varchar(128);
ALTER TABLE `account` DROP enabled;

SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

select * from cart 
join cart_book on cart.cart_id = cart_book.cart_id
join book on cart_book.book_id = book.book_id;

use bookstore2;

-- Thong ke so luong sach da ban (database: bookstoretest)
use bookstoretest;

select order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name, sum(order_detail.quantity) from order_detail
join book on book.book_id = order_detail.book_id
join orders on orders.order_id = order_detail.order_id
where date(order_date) between '2024-04-09' and '2024-04-10'
group by order_detail_id, order_detail.book_id, order_detail.order_id, book_code, book_name;
