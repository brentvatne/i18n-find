# i18n find
### Created by: Brent Vatne

## Why
It can be frustrating when working with a Rails project with
a lot of translations to find exactly where a translation key exists,
because keys are nested in yaml so you can't just search for
`en.home.product.title` - the line it is defined on will only have
`title:`

## Use it

```ruby
i18n-find en.home.product.title
# => en.yml:130
```

## Todo
- Given the current view directory, it will build the correct i18n
  string. (can I leverage something in Rails for this? it already does
this)

## Run the tests
Uses Rspec, to run the suite: `bundle install && rake`
*Tested with: Ruby 1.9.3p125*

## Read the code
Tips for navigating the code belong here

## Extend it
Tips for extending the code belong here
