# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

validateEmail = (email) ->
  return false if email == ''
  re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test email

validatePhone = (phone) ->
  return false if phone == ''
  phone = phone.replace(/[-+.,]/g, '')
  return $.isNumeric(phone)

preValidate = ->
  $inputs = $('#new_essay_application input')
  filledCounter = 0

  $inputs.each (key, input) ->
    if $.proxy(checkField, @)()
      filledCounter += 1
      $(@).closest('.panel__form-group').removeClass 'panel__form-group--error'
    else if @value != ''
      $(@).closest('.panel__form-group').addClass 'panel__form-group--error'

  $('.panel__submit-btn').attr disabled: filledCounter != $inputs.length

checkField = ->
  error = false
  switch @id
    when 'essay_application_phone'
      error = !validatePhone(@value)
    when 'essay_application_email'
      error = !validateEmail(@value)
    else
      error = @value == ''

  return !error

trackFiles = ->
  fileNames = []

  if @.files.length > 1
    for file in @.files
      fileNames.push file.name
  else if @.files.length
    fileNames.push @.files[0].name

  fileNames = fileNames.join(', ')

  if fileNames != ''
    $(@).siblings('.panel__form-control--fake-file-input').find('.panel__file-name')
      .addClass('panel__file-name--fill')
      .text fileNames

$(document)
  .on 'click', '.modal__close', (e) ->
    e.preventDefault()
    $('.modal').removeClass 'modal--visible'

  .on 'change', '#new_essay_application input', preValidate

  .on 'focus', '#new_essay_application input', ->
    $(@).parent().removeClass('panel__form-group--error')

  .on 'blur change', '#new_essay_application input', ->
    if !$.proxy(checkField, @)()
      $(@).closest('.panel__form-group').addClass 'panel__form-group--error'
      $('.panel__submit-btn').attr disabled: true
    else
      $(@).closest('.panel__form-group').removeClass 'panel__form-group--error'

  .on 'click', '.header__btn.header__btn--upload', (e) ->
    e.preventDefault()
    $('html, body').animate(scrollTop: $(".panel__section-title").offset().top, 1000)

$ ->
  #Store referrer and entrance page
  if $.userCameFromOutside()
    $.storeReferrer()
    $.storeEntrancePage()

  $('#essay_application_phone').inputmask "+9-999-999-9999"
  preValidate()
  $('.panel__form-file-input').each trackFiles

  # File input
  $('.panel__form-file-input').on 'change', trackFiles

  # Highlight fields on focus
  $('.panel__form-input')
    .on 'focus', ->
      $(@).closest('.panel__form-group').addClass 'panel__form-group--active'

    .on 'blur', ->
      $(@).closest('.panel__form-group').removeClass 'panel__form-group--active'
      
  # Accordion
  $('.panel__accordion-link').on 'click', (e) ->
    e.preventDefault()

    return if $(@).closest('.panel__accordion-item--active').length

    # Hide opened accordion
    $('.panel__accordion-content').slideUp 'fast'
    $('.panel__accordion-item').removeClass 'panel__accordion-item--active'

    # Show clicked accordion
    $(@).siblings('.panel__accordion-content').slideDown 'fast', ->
      $('html, body').animate(scrollTop: $(e.currentTarget).offset().top, 500)

    $(@).closest('.panel__accordion-item').addClass 'panel__accordion-item--active'



  # Mobile nav
  HEADER_ACTIVE_CLASS = 'header__nav--active'

  $headerNav = $('.header__nav')

  $(document)
    .on 'click', '.header__toggle-btn', (event) ->
      # Prevent propagation when open mobile nav
      event.stopPropagation()
      $headerNav.addClass HEADER_ACTIVE_CLASS

    .on 'click', '.header__nav', (event) ->
      # Prevent propagation when click inside mobile nav
      event.stopPropagation()

    .on 'click', '.header__close-btn', ->
      $headerNav.removeClass HEADER_ACTIVE_CLASS

    .on 'click', ->
      $headerNav.removeClass HEADER_ACTIVE_CLASS
