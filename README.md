# Blot

Tired of all those tables in those emails?
Blot is a DSL that lets you create them with ease and optimize with the Ink email framework.

## Installation

Add this line to your application's Gemfile:

    gem 'blot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blot

## Usage

### Layout

The layout is used to set up a boilerplate for you. Styles can be added to the header to make even more powerful.

#### Boilerplate Layout

This is the simpliest layout that you can create. Notice that it has no styles inside of it. Its just a raw boilerplate for you to work with.

```ruby
layout { '<!-- Email Content -->' }
```

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width" name="viewport" />
  </head>
  <body>
    <table class="body">
      <tr>
        <td align="center" class="center" valign="top">
          <center>

          <!-- Email Content -->

          </center>
        </td>
      </tr>
    </table>
  </body>
</html>
```

#### Styled Layout

Most developers want to style their emails. The `ink` option is used to specify where your `ink.css` file is located. This is usually in the vendor folder, but Rails will search for it for you. The `styles` option is used for you identify the custom styles that you use to modify Ink.

```ruby
layout(ink: 'ink.css', styles: ['typography.css', 'colors.css'])
```

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width" name="viewport" />
    <style rel="text/css">
      Ink Styles!
    </style>
    <style rel="text/css">
      Typography Styles!
      Color Styles!
    </style>
  </head>
  <body>
    <table class="body">
      <tr>
        <td align="center" class="center" valign="top">
          <center></center>
        </td>
      </tr>
    </table>
  </body>
</html>
```

### Grid

The grid in Blot matches Ink very well. It is able to produce rows, sub-grids, columns, block-grids, and panels. Here's some examples to learn from:

#### Rendering Two Rows: Twelve and Six by Six

```ruby
container do
  row do
    wrapper(class: 'wrapper last') do
      columns(:twelve, class: 'panel') { '.twelve.columns' }
    end
  end
  row do
    wrapper(class: 'wrapper') do
      columns(:six, class: 'panel') { '.six.columns' }
    end
    wrapper(class: 'wrapper last') do
      columns(:six, class: 'panel') { '.six.columns' }
    end
  end
end
```

```html
<table class="container">
  <tr>
    <td>

      <table class="row">
        <tr>
          <td class="wrapper last">

            <table class="twelve columns">
              <tr>
                <td class="panel">.twelve.columns</td>
                <td class="expander"></td>
              </tr>
            </table>

          </td>
        </tr>
      </table>

      <table class="row">
        <tr>
          <td class="wrapper">

            <table class="six columns">
              <tr>
                <td class="panel">.six.columns</td>
                <td class="expander"></td>
              </tr>
            </table>

          </td>
          <td class="wrapper last">

            <table class="six columns">
              <tr>
                <td class="panel">.six.columns</td>
                <td class="expander"></td>
              </tr>
            </table>

          </td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render Centered Content

```ruby
row do
  wrapper(class: 'wrapper') do
    columns(:six, class: 'center panel') { 'Centered content' }
  end
  wrapper(class: 'wrapper last') do
    columns(:six, class: 'center panel') do
      image_tag 'http://placehold.it/125x125&text=Centered%20Image', class: 'center', alt: 'centered image'
    end
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper">

      <table class="six columns">
        <tr>
          <td class="center panel">
            <center>Centered content</center>
          </td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
    <td class="wrapper last">

      <table class="six columns">
        <tr>
          <td class="center panel">
            <center><img alt="centered image" class="center" src="http://placehold.it/125x125&amp;text=Centered%20Image" /></center>
          </td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render Offset Content

```ruby
row do
  wrapper(class: 'wrapper offset-by-four') do
    columns(:eight, class: 'panel') { 'Offset Content' }
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper offset-by-four">
    
      <table class="eight columns">
        <tr>
          <td class="panel">Offset Content</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render Text-Padding

```ruby
row do
  wrapper(class: 'wrapper') do
    columns(:four, class: 'left-text-pad') { 'Text' }
  end
  wrapper(class: 'wrapper') do
    columns(:four) { 'Text' }
  end
  wrapper(class: 'wrapper last') do
    columns(:four, class: 'right-text-pad') { 'Text' }
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper">

      <table class="four columns">
        <tr>
          <td class="left-text-pad">Text</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
    <td class="wrapper">

      <table class="four columns">
        <tr>
          <td>Text</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
    <td class="wrapper last">

      <table class="four columns">
        <tr>
          <td class="right-text-pad">Text</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render Full-Width Rows

```ruby
row do
  wrapper(class: 'center', align: 'center') do
    container(class: 'wrapper last') do
      columns(:twelve) { 'Content' }
    end
  end
end
```

```html
<table class="row">
  <tr>
    <td align="center" class="center">
      <center>

        <table class="container">
          <tr>
            <td class="wrapper last">

              <table class="twelve columns">
                <tr>
                  <td>Content</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>

      </center>
    </td>
  </tr>
</table>
```

#### Render a Sub-Grid

```ruby
row do
  wrapper(class: 'wrapper') do
    columns(:eight, sub_columns: true) do
      sub_columns(:eight) { '.eight.sub-columns' } +
      sub_columns(:four, class: 'last') { '.four.sub-columns' }
    end
  end
  wrapper(class: 'wrapper last') do
    columns(:four) { '.four.columns' }
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper">

      <table class="eight columns">
        <tr>
          <td class="eight sub-columns">.eight.sub-columns</td>
          <td class="four sub-columns last">.four.sub-columns</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
    <td class="wrapper last">

      <table class="four columns">
        <tr>
          <td>.four.columns</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render a Block-Grid

```ruby
container do
  block_grid(up: :two) do
    wrapper { 'Column #1' }
    wrapper { 'Column #2' }
  end
end
```

```html
<table class="container">
  <tr>
    <td>

      <table class="block-grid two-up">
        <tr>
          <td>Column #1</td>
          <td>Column #2</td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render a Sidebar

```ruby
row do
  wrapper(class: 'wrapper') do
    columns(:eight) { 'Main content' }
  end
  wrapper(class: 'wrapper last') do
    columns(:four, class: 'panel') { 'Panel content' }
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper">

      <table class="eight columns">
        <tr>
          <td>Main content</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
    <td class="wrapper last">

      <table class="four columns">
        <tr>
          <td class="panel">Panel content</td>
          <td class="expander"></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

#### Render a Panel with a Sub-Grid

```ruby
columns(:twelve, class: 'panel sub-grid', sub_columns: true) do
  panel_sub_grid do
    sub_columns(:six) { 'Left Sub-Column' }
    sub_columns(:six) { 'Right Sub-Column' }
  end
end
```

```html
<table class="twelve columns">
  <tr>
    <td class="panel sub-grid">

      <table>
        <tr>
          <td class="six sub-columns">Left Sub-Column</td>
          <td class="six sub-columns">Right Sub-Column</td>
        </tr>
      </table>

    </td>
    <td class="expander"></td>
  </tr>
</table>
```

### Visibility

The visibility mimics Ink's vocabulary for showing and hiding tags on small devises.

#### Show for Small

```ruby
show_for_small
```

```html
<!--[if !mso]><!-- -->
  <table class="show-for-small">
    <tr>
      <td></td>
    </tr>
  </table>
<!--<![endif]-->
```

#### Hide for Small

```ruby
hide_for_small
```

```html
<table class="hide-for-small">
  <tr>
    <td></td>
  </tr>
</table>
```

#### Render Visibility for Columns

```ruby
row do
  wrapper(class: 'wrapper last') do
    show_for_small do
      columns(:twelve, class: 'panel') { '.show-for-small' }
    end
    hide_for_small do
      columns(:twelve, class: 'panel') { '.hide-for-small' }
    end
  end
end
```

```html
<table class="row">
  <tr>
    <td class="wrapper last">

      <!--[if !mso]><!-- -->
        <table class="show-for-small">
          <tr>
            <td>

              <table class="twelve columns">
                <tr>
                  <td class="panel">.show-for-small</td>
                  <td class="expander"></td>
                </tr>
              </table>
              
            </td>
          </tr>
        </table>
      <!--<![endif]-->

      <table class="hide-for-small">
        <tr>
          <td>

            <table class="twelve columns">
              <tr>
                <td class="panel">.hide-for-small</td>
                <td class="expander"></td>
              </tr>
            </table>

          </td>
        </tr>
      </table>

    </td>
  </tr>
</table>
```

### Buttons

The buttons in Blot are rendered through the simple `button` method. Examples below:

#### Simple Button

```ruby
button 'Button Label', '#', size: :button
```

```html
<table class="button">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Tiny Button

```ruby
button 'Button Label', '#', size: :tiny
```

```html
<table class="tiny-button">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Small Button

```ruby
button 'Button Label', '#', size: :small
```

```html
<table class="small-button">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Medium Button

```ruby
button 'Button Label', '#', size: :medium
```

```html
<table class="medium-button">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Large Button

```ruby
button 'Button Label', '#', size: :large
```

```html
<table class="large-button">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Primary Button

```ruby
button 'Button Label', '#', size: :button, color: :primary
```

```html
<table class="button primary">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Secondary Button

```ruby
button 'Button Label', '#', size: :button, color: :secondary
```

```html
<table class="button secondary">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Alert Button

```ruby
button 'Button Label', '#', size: :button, color: :alert
```

```html
<table class="button alert">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Success Button

```ruby
button 'Button Label', '#', size: :button, color: :success
```

```html
<table class="button success">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Radius Button

```ruby
button 'Button Label', '#', size: :button, radius: :radius
```

```html
<table class="button radius">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

#### Round Button

```ruby
button 'Button Label', '#', size: :button, radius: :round
```

```html
<table class="button round">
  <tr>
    <td>
      <a href="#">Button Label</a>
    </td>
  </tr>
</table>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/blot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
