
class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql= <<-SQL
            INSERT INTO pokemon (name, type, db)
            VALUES (?, ?, ?);
            SQL

        @db = DB[:conn].execute(sql, self.name, self.type, self.db)
        @id = DB[:conn].execute("SELECT last_insert_rowid()")[0][0]
    end

    def self.find
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = DB[:conn].execute(sql, id)[0][0]
        new_pokemon = Pokemon.new(result[0], result[1], result[2])
        new_pokemon
    end



end
