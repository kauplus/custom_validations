CHANGELOG
=================

1.0.0

New validators:

* validates_br_cnpj_of
* validates_br_cpf_of
* validates_br_postal_code_of
* validates_url_of


0.0.1

EmailValidator was our guinea pig (the first validator we built). It's working with ActiveModel::Validations and with the client_side_validations gem (in javascript). ActiveModel::Validations' validators were tested using RSpec. Javascripts tests were not written.
