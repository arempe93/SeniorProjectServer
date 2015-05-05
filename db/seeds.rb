###
#	Users
###

User.create email: 'rss002@connections.mcdaniel.edu', name: 'Richard Stuart', uid: '115631550163995469768', api_token: 'ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg', image: 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'
User.create email: 'mmp001@connections.mcdaniel.edu', name: 'Margaret Protzman', uid: '115612371892238912313', api_token: 'AsdajasAdsadasd98asdjisajasdada34.sdf4323eefDFSDFsdf3432fsdfsSDfdccv', image: 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'
User.create email: 'slk001@connections.mcdaniel.edu', name: 'Stephanie Krug', uid: '115619274392739812736', api_token: 'Asdajasd879sd79sa6dASDA1231FSDF5456fgdDGFDFgd434.sdf4323eefDasudhakshdaasdasfdccv', image: 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'
User.create email: 'smore@connections.mcdaniel.edu', name: 'Sarah More', uid: '115612371718020812736', api_token: 'DASdasdhask8129sahdadasjka9sFSDF5456fgdDGFDFgd434.sdf4323eefDFSDFsdf3432fsdfsSDfdccv', image: 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'

###
#	Books
###

Book.create isbn_13: '9781600076015', isbn_10: '1600076017', authors: "Jose A. Blanco; Maria Colbert", edition: "2 Pap/Psc", binding: "Paperback", publisher: "Vista Higher Learning", price: 90.9, image: 'http://ecx.images-amazon.com/images/I/31s1KcxycvL._SL194_.jpg', title: 'Ventanas- Lengua: Curso Intermedio De Lengua Espanola (Spanish Edition)', published: 'March 2008'
Book.create isbn_13: '9780136039884', isbn_10: '013603988X', authors: "Paul Heyne; Peter J. Boettke; David L. Prychitko", edition: "12", binding: "Paperback", publisher: "Prentice Hall", price: 46.67, image: 'http://ecx.images-amazon.com/images/I/51yoKYI9r3L._SL194_.jpg', title: "Study Guide for The Economic Way of Thinking", published: "May 2009"
Book.create isbn_13: '9781292024479', isbn_10: '129202447X', authors: "Hector Garcia-Molina; Jeffrey D. Ullman; Jennifer Widom", edition: "2 Pap/Psc", binding: "Paperback", publisher: "Vista Higher Learning", price: 90.9, image: 'http://ecx.images-amazon.com/images/I/514300RV1EL._SL194_.jpg', title: 'Database Systems: The Complete Book', published: 'March 2008'
Book.create isbn_13: '9780133407150', isbn_10: '0133407152', authors: "Randy Connolly; Ricardo Hoar", edition: "12", binding: "Paperback", publisher: "Prentice Hall", price: 46.67, image: 'http://ecx.images-amazon.com/images/I/51FYwtRBwmL._SL194_.jpg', title: "Fundamentals of Web Development", published: "May 2009"
Book.create isbn_13: '9780136016458', isbn_10: '0136016456', authors: "John J. Macionis", edition: "2 Pap/Psc", binding: "Paperback", publisher: "Vista Higher Learning", price: 90.9, image: 'http://ecx.images-amazon.com/images/I/510j%2BVL3WlL._SL194_.jpg', title: 'Sociology (12th Edition)', published: 'March 2008'
Book.create isbn_13: '9781449628079', isbn_10: '1449628079', authors: "Duncan A. Buell", edition: "12", binding: "Paperback", publisher: "Prentice Hall", price: 46.67, image: 'http://ecx.images-amazon.com/images/I/51BWYfHIxFL._SL194_.jpg', title: "Data Structures Using Java", published: "May 2009"
Book.create isbn_13: '9780205873470', isbn_10: '0205873472', authors: "Marilyn Stokstad; Michael Cothren", edition: "2 Pap/Psc", binding: "Paperback", publisher: "Vista Higher Learning", price: 90.9, image: 'http://ecx.images-amazon.com/images/I/61Vn3EWXlAL._SL194_.jpg', title: 'Art History (5th Edition)', published: 'March 2008'
Book.create isbn_13: '9781285057095', isbn_10: '1285057090', authors: "Ron Larson; Bruce H. Edwards", edition: "12", binding: "Paperback", publisher: "Prentice Hall", price: 46.67, image: 'http://ecx.images-amazon.com/images/I/51VkomG1XIL._SL194_.jpg', title: "Calculus", published: "May 2009"


###
#	Wanted Books
###

WantedBook.create user_id: 1, book_id: 2
WantedBook.create user_id: 1, book_id: 3
WantedBook.create user_id: 1, book_id: 6
WantedBook.create user_id: 1, book_id: 7

WantedBook.create user_id: 2, book_id: 4
WantedBook.create user_id: 2, book_id: 1
WantedBook.create user_id: 2, book_id: 8
WantedBook.create user_id: 2, book_id: 5

WantedBook.create user_id: 3, book_id: 6
WantedBook.create user_id: 3, book_id: 7
WantedBook.create user_id: 3, book_id: 2
WantedBook.create user_id: 3, book_id: 3

WantedBook.create user_id: 4, book_id: 8
WantedBook.create user_id: 4, book_id: 5
WantedBook.create user_id: 4, book_id: 4
WantedBook.create user_id: 4, book_id: 1

###
#	Owned Books
###

OwnedBook.create user_id: 1, book_id: 1
OwnedBook.create user_id: 1, book_id: 4
OwnedBook.create user_id: 1, book_id: 5
OwnedBook.create user_id: 1, book_id: 8

OwnedBook.create user_id: 2, book_id: 3
OwnedBook.create user_id: 2, book_id: 2
OwnedBook.create user_id: 2, book_id: 7
OwnedBook.create user_id: 2, book_id: 6

OwnedBook.create user_id: 3, book_id: 5
OwnedBook.create user_id: 3, book_id: 8
OwnedBook.create user_id: 3, book_id: 1
OwnedBook.create user_id: 3, book_id: 4

OwnedBook.create user_id: 4, book_id: 7
OwnedBook.create user_id: 4, book_id: 6
OwnedBook.create user_id: 4, book_id: 3
OwnedBook.create user_id: 4, book_id: 2

###
#	Trades
###