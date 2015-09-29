# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )


# Vendor Plugins
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "plugins")

# General Assets
Rails.application.config.assets.precompile += %w(
  menuzord.js
  jquery.flexslider-min.js
  owl.carousel.min.js
  jquery.isotope.js
  imagesloaded.js
  jquery.magnific-popup.min.js
  jquery.countTo.js
  visible.js
  smooth.js
  wow.min.js
  jquery.nav.js
  scripts.js

  slider-revolution/css/extralayers.css
  slider-revolution/css/settings.css
  slider-revolution/js/jquery.themepunch.tools.min.js
  slider-revolution/js/jquery.themepunch.revolution.js
)

# Ambassador index Assets ( js & css )
Rails.application.config.assets.precompile += %w(
  flexslider.min.js
  lightbox.min.js
  masonry.min.js
  twitterfetcher.min.js
  spectragram.min.js
  ytplayer.min.js
  countdown.min.js
  smooth-scroll.min.js
  scripts.js

  jquery.tagsinput/jquery.tagsinput.css
  jquery.tagsinput/jquery.tagsinput.js

  ambassadors.css
  parallax.js
)


# Register Assets (js & css)
Rails.application.config.assets.precompile += %w(
  bootstrap-datepicker/bootstrap-datepicker3.css
  bootstrap-datepicker/bootstrap-datepicker.js
  jquery.scrollintoview/jquery.scrollintoview.js
  register.js
  register.css
)
