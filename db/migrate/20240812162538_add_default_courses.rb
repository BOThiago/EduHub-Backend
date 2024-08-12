class AddDefaultCourses < ActiveRecord::Migration[7.1]
  def up
    Course.create!([
      {
        id: 1,
        title: "Introdução à Programação",
        description: "Curso básico para iniciantes em programação, cobrindo conceitos fundamentais.",
        end_date: "2025-01-15"
      },
      {
        id: 2,
        title: "Marketing Digital Avançado",
        description: "Curso avançado sobre estratégias de marketing digital, incluindo SEO e campanhas de mídia social.",
        end_date: "2024-10-20"
      },
      {
        id: 3,
        title: "Gestão de Projetos Ágeis",
        description: "Curso intermediário sobre práticas ágeis na gestão de projetos, com ênfase no Scrum.",
        end_date: "2025-03-10"
      },
      {
        id: 4,
        title: "Data Science para Iniciantes",
        description: "Introdução à ciência de dados, cobrindo conceitos básicos e uso de ferramentas como Python.",
        end_date: "2025-08-05"
      },
      {
        id: 5,
        title: "Fundamentos da Fotografia",
        description: "Curso básico de fotografia, abordando técnicas de captura de imagem e composição.",
        end_date: "2025-05-18"
      }
    ])
  end

  def down
    Course.where(id: [1, 2, 3, 4, 5]).delete_all
  end
end
