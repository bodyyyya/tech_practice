ActiveAdmin.register Category do
  permit_params :name,
                properties_attributes: [
                  :id, :name, :options, :_destroy,
                  property_values_attributes: [:id, :value, :_destroy]
                ]

  form do |f|
    f.inputs "Категорія" do
      f.input :name
    end

    f.inputs "Параметри" do
      f.has_many :properties, allow_destroy: true, new_record: "Додати параметр" do |p|
        p.input :name
        p.input :options, as: :text, hint: "JSON-масив варіантів (якщо потрібно)"
        
        p.has_many :property_values, allow_destroy: true, new_record: "Додати значення" do |pv|
          pv.input :value
        end
      end
    end

    f.actions
  end
end
