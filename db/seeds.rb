###
#	Users
###

User.create email: 'andrewrempe@gmail.com', name: 'Andrew Rempe', uid: '115631550163995469768', api_token: 'ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg', image: 'https://lh3.googleusercontent.com/-U6b9_RkEdm4/AAAAAAAAAAI/AAAAAAAAACE/wtO7mpUNV3I/photo.jpg'
User.create email: 'ctc007@mcdaniel.edu', name: 'Chris Celi', uid: '115612371892739812736', api_token: 'Asdajasd879sd79sa6dASDA1231FSDF5456fgdDGFDFgd434.sdf4323eefDFSDFsdf3432fsdfsSDfdccv', image: 'http://www.imgur.com'

###
#	Books
###

Book.create isbn_13: '9781600076015', isbn_10: '1600076017', authors: "Jose A. Blanco; Maria Colbert", edition: "2 Pap/Psc", binding: "Paperback", publisher: "Vista Higher Learning", price: 90.9, image: 'http://ecx.images-amazon.com/images/I/31s1KcxycvL._SL194_.jpg', title: 'Ventanas- Lengua: Curso Intermedio De Lengua Espanola (Spanish Edition)', published: 'March 2008'
Book.create isbn_13: '9780136039884', isbn_10: '013603988X', authors: "Paul Heyne; Peter J. Boettke; David L. Prychitko", edition: "12", binding: "Paperback", publisher: "Prentice Hall", price: 46.67, image: 'http://ecx.images-amazon.com/images/I/51yoKYI9r3L._SL194_.jpg', title: "Study Guide for The Economic Way of Thinking", published: "May 2009"

###
#	Wanted Books
###

WantedBook.create user_id: 1, book_id: 1
WantedBook.create user_id: 2, book_id: 2

###
#	Owned Books
###

OwnedBook.create user_id: 1, book_id: 2
OwnedBook.create user_id: 2, book_id: 1

###
#	Trades
###

Trade.create sender_id: 1, receiver_id: 2, sender_books: [2], receiver_books: [1], sender_extras: 0.0, receiver_extras: 0.0
Trade.create sender_id: 2, receiver_id: 1, sender_books: [2], receiver_books: [1], sender_extras: 0.0, receiver_extras: 10.0, counter_offer_id: 1
Trade.create sender_id: 2, receiver_id: 1, sender_books: [2], receiver_books: [1], sender_extras: 0.0, receiver_extras: 5.0, counter_offer_id: 2