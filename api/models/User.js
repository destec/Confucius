var User = {
  // Enforce model schema in the case of schemaless databases
  schema: true,

  attributes: {
    code: {
      type: 'string',
      unique: true,
    },
    username: {
      type: 'string',
      unique: true
    },
    email: {
      type: 'email',
    },
    passports: {
      collection: 'Passport',
      via: 'user'
    }
  }
};

module.exports = User;
