require 'telegram/bot'

# Replace with your own API token
API_TOKEN = 'YOUR_TELEGRAM_BOT_API_TOKEN'

Telegram::Bot::Client.run(API_TOKEN) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      if message.text == '/start'
        # Create an inline keyboard with a button
        keyboard = [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Click me!', callback_data: 'button_clicked')
        ]
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [keyboard])
        
        # Send a message with the inline button
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, choose an option:", reply_markup: markup)
      end
    when Telegram::Bot::Types::CallbackQuery
      # Handle button click
      if message.data == 'button_clicked'
        bot.api.send_message(chat_id: message.from.id, text: "You clicked the button!")
      end
    end
  end
end
