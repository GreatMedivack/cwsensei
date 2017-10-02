require 'telegram/bot'
require 'date'
require 'ap'
token = '462873083:AAGcnvU6dTm6NsstYjV6jyrbwR2jjO9gdJI'


username = 'Залупка'
profession = 'Рыцарь'
lvl = '15'
attack = '50'
defense = '1'
expcur = '1000'
expup = '2000'
gold = '100'

forge = """
⚒На верстаке лежит:
[пусто]

📦Содержимое склада:
/a_109 Плотная ткань x 4
/a_128 Шнурок x 2
"""

workShop = """
Изученные рецепты:
/craft_145 Упаковочный материал 1💰

Твои ресурсы на складе: /more
"""

broker ="""
📥Товары на продажу:
Порошок
28💰 (606706шт) купить: /wtb_107
Шкура животного
11💰 (424466шт) купить: /wtb_103
Ветки
33💰 (353539шт) купить: /wtb_102
Нитки
23💰 (267891шт) купить: /wtb_101
Стальная нить
81💰 (265905шт) купить: /wtb_129"""

castle = """
🇰🇮Сумрачный замок

41 минуту до битвы

Казна замка:
38729💰 15🌲 139⛰
Отчет о битве: /report
Общий отчет: @chatwarsreports

💬Чат замка: ссылка (https://t.me/joinchat/AAAAAEEMFsMACHPmHhjhqA)
"""

shop = """Добро пожаловать, Господин Ямада. Уверен, тут ты найдешь то, что ищешь.

Снаряжение — любое оружие и броня за твою звонкую монету
Алхимик — местному алхимику есть чем тебя порадовать за 💠
Зверинец - питомцы и еда для них.
Скупка предметов — не очень жалуем б/у, но сделаем исключение для тебя.

Если же нужно что-то более эксклюзивное, загляни в 💠Магазин кристаллов — /shop
"""

hero = """
Битва семи замков через 1ч 2 минуты!

🇰🇮#{username}, #{profession} Сумрачного замка
🏅Уровень: #{lvl}
⚔️Атака: #{attack} 🛡Защита: #{defense}
🔥Опыт: #{expcur}/#{expup}
🔋Выносливость: 5/5
💰#{gold} 💠0

🎽Экипировка +64⚔️+25🛡+1🍀
🎒Рюкзак: 9/15 /inv

Состояние:
🛌Отдых

Подробнее: /hero

"""

mainMenu =  [['⚔️Атака', '🛡Защита', '🌲Квесты'], ['🏅Герой', '🏰Замок', '💬']]
castleMenu = [['📯Арена','🏚Лавка','⚖️Биржа'],['⚒Мастерская','🏘Постройки'],['🍺Таверна','⬅️Назад']]
shopMenu = [['Снаряжение','Скупка предметов'],['⚗️Алхимик','🐾Зверинец'],['Другое','⬅️Назад']]
brokerMenu = [['📥Покупка','📤Продажа'],['📊Биржа','⬅️Назад']]
reportMenu = [['📥Покупка','📤Продажа'],['📃Отчеты','⬅️Назад']]
workshopMenu = [['⚒Верстак','📖Рецепты'],['🏷Упаковать','⬅️Назад']]
forgeMenu = [['⚒Изготовить','📖Рецепты'],['❌Сбросить','⬅️Назад']]

markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: mainMenu, one_time_keyboard: false, resize_keyboard: true)


require 'sqlite3'

@db = SQLite3::Database.new 'database.db'


Telegram::Bot::Client.run(token) do |bot|

	bot.listen do |message|

		case message
		  when Telegram::Bot::Types::CallbackQuery

		  when Telegram::Bot::Types::InlineQuery

		  when Telegram::Bot::Types::Message

		  	if message.text == '🏅Герой'
		  		bot.api.send_message(chat_id: message.from.id, text: hero, reply_markup: markup)
		  		next
		  	end

		  	if message.text == '🏰Замок'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: castleMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: castle, reply_markup: markup)
		  		next
		  	end


		  	if message.text == '🏚Лавка'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: shopMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: shop, reply_markup: markup)
		  		next
		  	end

		  	if message.text == '⬅️Назад'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: mainMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: hero, reply_markup: markup)
		  		next
		  	end

		  	if message.text == '⚖️Биржа' || message.text == '📊Биржа'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: brokerMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: broker, reply_markup: markup)
		  		next
		  	end

		  	if message.text == '⚒Мастерская'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: workshopMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: workShop, reply_markup: markup)
		  		next
		  	end

		  	if message.text == '⚒Верстак'
		  		markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: forgeMenu, one_time_keyboard: false, resize_keyboard: true)
		  		bot.api.send_message(chat_id: message.from.id, text: forge, reply_markup: markup)
		  		next
		  	end

		  	msg = "Герой"
		    bot.api.send_message(chat_id: message.from.id, text: msg, reply_markup: markup)
		end
	end
end
