require('pg')

class Property
attr_accessor :address, :value, :no_of_bedrooms, :year_built, :build

attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"] #telling it to initialise only if there is an id
    @address = options["address"]
    @value = options["value"].to_i
    @no_of_bedrooms = options["no_of_bedrooms"].to_i
    @year_built = options["year_built"].to_i
    @build = options["build"]
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "INSERT INTO properties(address, value, no_of_bedrooms, year_built, build) VALUES($1, $2, $3, $4, $5) RETURNING *"

    values = [@address, @value, @no_of_bedrooms, @year_built, @build]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def Property.property_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties"

    db.prepare("find_all", sql)
    results = db.exec_prepared("find_all")
    db.close

    return results.map{|result| Property.new(result)}
  end

  def Property.find_property_by_id(id)
    db=PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE id = $1"

    values = [id]

    db.prepare("find_by_id", sql)
    details = db.exec_prepared("find_by_id", values)
    db.close

      return details.map{|detail_hash| Property.new(detail_hash)}

      #could have done variable = details
      #return Property.new(variable) this is the two step method of above.  bescially we need a hash as that is what we have told the class it needs(options)
  end

  def Property.find_property_by_address(address)
    db = PG.connect ({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE address = $1"

    values = [address]

    db.prepare("find_by_address", sql)
    detail = db.exec_prepared("find_by_address", values)

    db.close

    return detail.map{|detail| Property.new(detail)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM properties"

    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")

    db.close
  end

  def Property.delete1(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM properties WHERE id = $1"

      values = [id]

      db.prepare("delete1", sql)
      db.exec_prepared("delete1", values)

      db.close

    end

    def update()

      db = PG.connect({dbname: "property_tracker", host: "localhost"})

      sql = "UPDATE properties SET (address, value, no_of_bedrooms, year_built, build) = ($1, $2, $3, $4, $5) WHERE id = $6"

      values = [@address, @value, @no_of_bedrooms, @year_built, @build,@id]

      db.prepare("update", sql)
      db.exec_prepared("update", values)

      db.close
    end
end
