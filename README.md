# Moysklad Integration

The main goal of this gem to make your work with moysklad.ru service much easier without the necessity of writing tons of code. You can use this gem to integrate any service through API with moysklad.ru I used it to make an app that will help Shopify communicates with moysklad.ru

This gem works with API 1.1 of moysklad.ru

---

Основная цель этой библиотеки (гема) - сделать работу с сервисом moysklad.ru намного проще без необходимости написания тонны кода. Вы можете использовать этот гем для интеграции любого сервиса через API с moysklad.ru. Я использовал его для создания приложения, которое поможет Shopify общаться с moysklad.ru

Этот гем работает с API 1.1 moysklad.ru

## Installation / Установка

Add this line to your application's Gemfile: / Добавьте данную строчку в свой Gemfile

```ruby
gem 'moysklad_integration'
```

And then execute: / Затем выполните команду:

    $ bundle install

Or install it yourself as: / Или установите напрямую в систему:

    $ gem install moysklad_integration

Add to your .env file credentials for moysklad.ru: / Добавьте в .env файл данные для подключения к moysklad.ru

```
export MOYSKLAD_USERNAME=your_username
export MOYSKLAD_PASSWORD=your_password
```

## Usage / Использование

```ruby
moysklad_service = MoyskladIntegration::Service.new
```

#### Create entity / Создания сущности (объекта)

```ruby
moysklad_service.create(:entity_name, { entity_params: like_hash })
```

#### Get all entities of the certain type / Получение сущностей (объектов) определенного типа

```ruby
moysklad_service.get(:entity_name)
```

#### Find all entities of a certain type with specific fields / Найти все сущности (объекты) определенного типа с определенными полями

```ruby
moysklad_service.filter(:entity_name, { search_params: like_hash })
```

#### Find all entities of a certain type with specific fields / Найти все сущности (объекты) определенного типа с определенными полями

```ruby
moysklad_service.filter(:entity_name, { search_params: like_hash })
```

#### Update an entity / Обновить сущность (объект)

```ruby
entity = moysklad_service.get(:entity_name)
entity.update({ name: :new_name })
```

#### Entity link / Ссылка на сущность (объект)

```ruby
entity = moysklad_service.get(:entity_name)
entity.meta_link
```

#### Add positions to entity / Добавить позиции к сущности (объекту)

```ruby
entity = moysklad_service.get(:entity_name)
entity.add_positions([{ position_params: in_hash }])
```

#### Update positions of an entity / Обновить позиции в сущности (объекте)

```ruby
entity = moysklad_service.get(:entity_name)
entity.update_positions([{ position_params: in_hash }])
```

**Examples are below / Примеры ниже**

### Customer order / Договор: заказ покупателя

#### Creation / Создание

```ruby
moysklad_service.create(:customerorder, { name: 'Test Order', organization: organization.meta_link, agent: counterparty.meta_link })
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vkalach/moysklad_integration. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/vkalach/moysklad_integration/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MoyskladIntegration project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/vkalach/moysklad_integration/moysklad_integration/blob/master/CODE_OF_CONDUCT.md).
