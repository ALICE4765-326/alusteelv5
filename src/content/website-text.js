/**
 * Website Text Content
 * 
 * Este ficheiro contém todo o conteúdo textual utilizado no site.
 * Modifique este ficheiro para atualizar o texto no site sem alterar a estrutura do código.
 */

export const siteInfo = {
  name: "Alusteel",
  tagline: "by Plano Extrovertido",
  description: "Especialista em carpintaria de alumínio e PVC e serralharia",
  phone: "XX XX XX XX XX",
  email: "contacto@alusteel.pt",
  address: "A definir"
};

export const navigation = {
  menuItems: [
    { href: '/', text: 'Início' },
    { href: '/nos-metiers', text: 'Nosso Ofício' },
    { href: '/nos-chantiers', text: 'Nossos Projetos' },
    { href: '/nos-partenaires', text: 'Nossos Parceiros' },
    { href: '/temoignages', text: 'Testemunhos' },
    { href: '/blog', text: 'Blog' },
    { href: '/contact', text: 'Contacto' }
  ],
  cta: "Pedir orçamento"
};

export const homePage = {
  hero: {
    title: "Alusteel",
    subtitle: "A excelência ao serviço dos seus projetos",
    description1: "Precisa de carpintaria e soluções em alumínio sob medida, com qualidade, preço justo e rapidez? Podemos ajudá-lo!",
    description2: "A nossa equipa de gestão tem mais de 20 anos de experiência, Alusteel é o parceiro essencial para todos os seus projetos em alumínio, aço e PVC. Concebemos e fabricamos uma vasta gama de carpintarias e soluções sob medida: janelas, portas de correr, portas, mas também escadas, guardas, portões, cercas, serralharia e muito mais.",
    buttons: {
      contact: "Contacte-nos",
      projects: "Os nossos projetos"
    }
  },
  manufacturing: {
    title: "A nossa expertise de fabrico",
    description1: "A nossa fábrica está equipada com máquinas modernas, permitindo-nos trabalhar com todas as marcas e gamas disponíveis: Cortizo, Technal, Schüco e outras.",
    description2: "Graças ao nosso equipamento de ponta e know-how, garantimos produtos de alta qualidade, fabricados com precisão e respeitando as normas mais exigentes.",
    linkText: "Saiba mais sobre o nosso ofício",
    image: "https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    imageAlt: "Fábrica moderna de fabrico"
  },
  advantages: {
    title: "Por que escolher a Alusteel?",
    items: [
      {
        title: "Qualidade premium",
        description: "Materiais robustos e duráveis",
        icon: "M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
      },
      {
        title: "Preço justo",
        description: "Desempenho ao melhor preço",
        icon: "M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
      },
      {
        title: "Fabricação europeia",
        description: "Produção controlada na nossa fábrica em Portugal",
        icon: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
      },
      {
        title: "Prazos ultra-competitivos",
        description: "Sabemos que o seu tempo é precioso",
        icon: "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
      },
      {
        title: "Acompanhamento total",
        description: "Acompanhamento completo com os nossos parceiros",
        icon: "M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
      }
    ],
    cta: "Iniciar o seu projeto"
  }
};

export const nosMetiersPage = {
  hero: {
    title: "Embeleze e proteja a sua casa com a Alusteel",
    description: "Na Alusteel, damos vida aos seus projetos com realizações sob medida, pensadas para embelezar, proteger e valorizar o seu espaço."
  },
  menuiserie: {
    title: "Carpintaria: Elegância e desempenho no coração da sua casa",
    sections: [
      {
        title: "Carpintarias que fazem a diferença",
        description: "Janelas, portas, portas de correr, portões... Concebemos soluções estéticas e de alto desempenho. Pensadas para oferecer isolamento ideal, solidez à prova de tudo e um estilo único.",
        icon: "M9 5l7 7-7 7"
      },
      {
        title: "Materiais premium e conformes com as normas mais exigentes",
        description: "As nossas carpintarias em alumínio e PVC são fabricadas respeitando as normas NF (CSTB) e CE, garantindo qualidade, segurança e durabilidade. Graças a processos de fabrico inovadores, asseguramos produtos de alto desempenho, adaptados às exigências térmicas e acústicas mais rigorosas.",
        icon: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
      },
      {
        title: "Instalação fiável e acompanhamento 100% garantido",
        description: "Graças aos nossos parceiros qualificados sempre acompanhados e controlados pelas nossas equipas, beneficia de uma instalação fiável e eficaz, realizada segundo as regras da arte. Asseguramos um acompanhamento completo de cada obra, desde a conceção à instalação, para garantir um serviço impecável e um resultado à altura das suas expectativas.",
        icon: "M5 13l4 4L19 7"
      },
      {
        title: "Carports e pérgulas: Proteção e elegância para os seus exteriores",
        description: "Para além das nossas carpintarias, também oferecemos carports e pérgulas em alumínio, concebidos para proteger os seus veículos ou embelezar o seu terraço com um toque moderno e refinado.",
        icon: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
      },
      {
        title: "Estores: Desempenho, segurança e estética à prova de tudo",
        description: "Eleve o seu conforto com os nossos estores, incluindo os modelos com lâminas bioclimáticas! Ofereça à sua casa um isolamento perfeito, segurança ideal e um design personalizado.",
        icon: "M19 9l-7 7-7-7"
      }
    ],
    gallery: {
      title: "As nossas realizações em carpintaria",
      description: "Descubra alguns exemplos dos nossos projetos de carpintaria em alumínio e PVC",
      images: [
        {
          url: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3",
          alt: "Janelas em alumínio",
          title: "Janelas em alumínio"
        },
        {
          url: "https://images.unsplash.com/photo-1600573472591-ee6c563aaec9?ixlib=rb-4.0.3",
          alt: "Porta de entrada design",
          title: "Porta de entrada design"
        },
        {
          url: "https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?ixlib=rb-4.0.3",
          alt: "Porta de correr",
          title: "Porta de correr"
        },
        {
          url: "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3",
          alt: "Pérgula em alumínio",
          title: "Pérgula em alumínio"
        }
      ]
    },
    conclusion: "Transforme o seu interior e os seus exteriores com soluções que aliam estética, conforto e segurança.",
    cta: "Contacte-nos agora para um orçamento personalizado!"
  },
  serrurerie: {
    title: "Serralharia: Alie segurança e design com criações únicas",
    sections: [
      {
        title: "A excelência ao serviço da sua segurança",
        description: "Escadas metálicas, guardas, cercas... Criamos elementos de serralharia de alta qualidade, concebidos para proteger os seus espaços enquanto acrescentam um toque de refinamento.",
        icon: "M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
      },
      {
        title: "Escadas e guardas que atraem o olhar",
        description: "Modernas, elegantes, robustas: as nossas escadas e guardas em aço são verdadeiras peças arquitetónicas, concebidas para se integrarem perfeitamente no seu interior e exterior.",
        icon: "M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
      },
      {
        title: "Cercas e portões: Proteja o seu espaço com estilo e conformidade",
        description: "As nossas cercas e portões são fabricados respeitando as normas de segurança e resistência em vigor, garantindo-lhe uma proteção ideal e uma durabilidade excecional face às intempéries e utilizações intensivas.",
        icon: "M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
      },
      {
        title: "Uma instalação especializada e um acompanhamento de A a Z",
        description: "Os nossos produtos de serralharia são instalados por profissionais experientes, garantindo-lhe uma implementação impecável e conforme com as exigências de segurança mais rigorosas. Com o nosso acompanhamento rigoroso em todas as obras, asseguramos que cada projeto é realizado com precisão e atenção ao detalhe.",
        icon: "M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
      }
    ],
    gallery: {
      title: "As nossas realizações em serralharia",
      description: "Descubra alguns exemplos dos nossos projetos de serralharia e metalurgia",
      images: [
        {
          url: "https://images.unsplash.com/photo-1600566752355-35792bedcfea?ixlib=rb-4.0.3",
          alt: "Escada metálica",
          title: "Escada metálica"
        },
        {
          url: "https://images.unsplash.com/photo-1600573472592-999f3c32d1b9?ixlib=rb-4.0.3",
          alt: "Guarda design",
          title: "Guarda design"
        },
        {
          url: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3",
          alt: "Portão em aço",
          title: "Portão em aço"
        },
        {
          url: "https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?ixlib=rb-4.0.3",
          alt: "Cerca metálica",
          title: "Cerca metálica"
        }
      ]
    },
    conclusion: "A sua segurança e o seu conforto merecem o melhor. Confie na Alusteel para realizações sob medida, aliando desempenho e prestígio.",
    cta: "Precisa de um projeto único? Contacte-nos hoje mesmo!"
  }
};

export const nosChantiers = {
  hero: {
    title: "Os Nossos Projetos",
    description: "Descubra os nossos projetos realizados com paixão e expertise."
  },
  categories: [
    "Todos",
    "Janelas",
    "Portas",
    "Varandas",
    "Serralharia"
  ],
  projects: [
    {
      id: 1,
      title: "Carpintaria em alumínio",
      category: "Janelas",
      description: "Instalação de janelas em alumínio para uma villa moderna",
      city: "Lyon",
      imageUrl: "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3"
    },
    {
      id: 2,
      title: "Porta de entrada",
      category: "Portas",
      description: "Porta de entrada design em alumínio preto mate",
      city: "Paris",
      imageUrl: "https://images.unsplash.com/photo-1600573472591-ee6c563aaec9?ixlib=rb-4.0.3"
    },
    {
      id: 3,
      title: "Varanda moderna",
      category: "Varandas",
      description: "Varanda contemporânea com telhado plano",
      city: "Bordeaux",
      imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3"
    },
    {
      id: 4,
      title: "Serralharia",
      category: "Serralharia",
      description: "Instalação de um sistema de segurança de alto desempenho",
      city: "Marseille",
      imageUrl: "https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?ixlib=rb-4.0.3"
    },
    {
      id: 5,
      title: "Porta de correr",
      category: "Janelas",
      description: "Porta de correr com sistema de ocultação para uma vista panorâmica",
      city: "Nice",
      imageUrl: "https://images.unsplash.com/photo-1600566752355-35792bedcfea?ixlib=rb-4.0.3"
    },
    {
      id: 6,
      title: "Porta de garagem",
      category: "Portas",
      description: "Porta de garagem seccionada motorizada",
      city: "Toulouse",
      imageUrl: "https://images.unsplash.com/photo-1600573472592-999f3c32d1b9?ixlib=rb-4.0.3"
    }
  ],
  cta: {
    title: "Tem um projeto?",
    description: "Contacte-nos para dar vida às suas ideias com a nossa expertise.",
    buttonText: "Pedir um orçamento"
  }
};

export const nosPartenaires = {
  hero: {
    title: "Especialistas ao Nosso Lado",
    description: "Para garantir serviços completos e de qualidade, a Alusteel rodeia-se de parceiros fiáveis e reconhecidos na sua área."
  },
  partners: [
    {
      name: "ProPoseAlu",
      description: "Especialista em instalação, a ProPoseAlu garante uma instalação cuidada e profissional das nossas carpintarias e elementos de serralharia, em toda a França.",
      icon: "M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z",
      image: "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3"
    },
    {
      name: "Portails en Kits",
      description: "Especialista em kits de portões, portões pequenos e acessórios de manutenção, a Portails en Kits oferece soluções fáceis de montar, robustas e adaptadas a todas as necessidades.",
      icon: "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z",
      image: "https://images.unsplash.com/photo-1600573472591-ee6c563aaec9?ixlib=rb-4.0.3"
    },
    {
      name: "Premium a Justo Preço",
      description: "Portões, portões pequenos, pérgulas e carports: Premium a Justo Preço oferece produtos de alta qualidade a preços acessíveis, com encomenda online e entrega em toda a França.",
      icon: "M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z",
      image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3"
    },
    {
      name: "VProBâtiment",
      description: "A VProBâtiment é o parceiro ideal para os seus projetos de construção e renovação, aliando expertise e qualidade de execução.",
      icon: "M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4",
      image: "https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?ixlib=rb-4.0.3"
    }
  ],
  cta: {
    title: "Trabalhemos juntos",
    description: "Com os nossos parceiros, garantimos-lhe soluções completas, desde a escolha do produto à sua instalação.",
    buttonText: "Contacte-nos para o seu projeto"
  }
};

export const temoignages = {
  hero: {
    title: "O que dizem os nossos clientes",
    description: "Descubra os feedbacks dos nossos clientes."
  },
  testimonials: [
    {
      name: "Maria Duarte",
      role: "Proprietária",
      content: "Uma equipa profissional e atenta. A qualidade das carpintarias é excepcional e a instalação foi perfeita.",
      image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3",
      rating: 5
    },
    {
      name: "João Martins",
      role: "Arquiteto",
      content: "Trabalho regularmente com a Alusteel para os meus projetos. A sua expertise e reatividade são trunfos importantes.",
      image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3",
      rating: 5
    },
    {
      name: "Sofia Lopes",
      role: "Decoradora de interiores",
      content: "Produtos de alta qualidade e um serviço ao cliente irrepreensível. Recomendo vivamente!",
      image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3",
      rating: 5
    }
  ],
  cta: {
    title: "Você também, partilhe a sua experiência",
    buttonText: "Deixar uma opinião"
  }
};

export const blog = {
  hero: {
    title: "Notícias & Expertise",
    description: "Descubra os nossos artigos, conselhos e notícias sobre carpintaria em alumínio, PVC e serralharia."
  },
  articles: [
    {
      title: "As tendências de carpintaria 2025",
      excerpt: "Descubra as últimas inovações em matéria de carpintaria em alumínio e PVC.",
      date: "15 Março 2025",
      category: "Tendências",
      image: "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3"
    },
    {
      title: "Como escolher as suas janelas?",
      excerpt: "Guia completo para selecionar as janelas adaptadas à sua habitação.",
      date: "10 Março 2025",
      category: "Guias",
      image: "https://images.unsplash.com/photo-1600573472591-ee6c563aaec9?ixlib=rb-4.0.3"
    },
    {
      title: "A segurança em primeiro lugar",
      excerpt: "As soluções de serralharia modernas para proteger a sua casa.",
      date: "5 Março 2025",
      category: "Segurança",
      image: "https://images.unsplash.com/photo-1600566752355-35792bedcfea?ixlib=rb-4.0.3"
    }
  ],
  newsletter: {
    title: "Mantenha-se informado",
    description: "Inscreva-se na nossa newsletter para receber os nossos últimos artigos e conselhos.",
    buttonText: "Inscrever-se",
    placeholder: "O seu email"
  }
};

export const contact = {
  hero: {
    title: "Dê vida aos seus projetos hoje mesmo!",
    description: "Janelas, portões, escadas, pérgulas... Você imagina, nós realizamos! A Alusteel acompanha-o com soluções sob medida, duráveis e elegantes.",
    subDescription: "Peça já o seu orçamento gratuito e beneficie de um acompanhamento personalizado!"
  },
  features: [
    {
      title: "Uma equipa reativa e à sua escuta",
      icon: "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
    },
    {
      title: "Conselhos adaptados às suas necessidades",
      icon: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
    },
    {
      title: "Uma resposta rápida para avançar sem esperar",
      icon: "M13 10V3L4 14h7v7l9-11h-7z"
    }
  ],
  contactInfo: {
    title: "Contacte-nos",
    phone: {
      title: "Telefone",
      value: "XX XX XX XX XX"
    },
    email: {
      title: "Email",
      value: "contacto@alusteel.pt"
    },
    address: {
      title: "Morada",
      value: "A definir"
    }
  },
  form: {
    title: "Envie-nos uma mensagem",
    fields: {
      name: "Nome",
      email: "Email",
      subject: "Assunto",
      message: "Mensagem"
    },
    button: "Enviar o meu pedido"
  }
};

export const admin = {
  dashboard: {
    title: "Administração",
    backToSite: "Voltar ao site",
    logout: "Terminar sessão",
    sections: [
      {
        title: "Gestão de projetos",
        description: "Gerir os seus projetos e realizações",
        icon: "M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
      },
      {
        title: "Gestão de parceiros",
        description: "Gerir os seus parceiros comerciais",
        icon: "M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
      },
      {
        title: "Gestão de testemunhos",
        description: "Gerir as opiniões dos seus clientes",
        icon: "M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z"
      },
      {
        title: "Gestão do blog",
        description: "Gerir os seus artigos e notícias",
        icon: "M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"
      },
      {
        title: "Gestão das páginas",
        description: "Gerir a visibilidade das suas páginas",
        icon: "M4 6h16M4 10h16M4 14h16M4 18h16"
      },
      {
        title: "Gestão da fábrica",
        description: "Gerir as fotos da fábrica",
        icon: "M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
      },
      {
        title: "Gestão dos ofícios",
        description: "Gerir as fotos dos ofícios",
        icon: "M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
      }
    ],
    logo: {
      title: "Logótipo",
      button: "Alterar o logótipo"
    },
    contactInfo: {
      title: "Informações de contacto",
      phone: "Telefone",
      email: "Email",
      address: "Morada",
      button: "Guardar as alterações"
    }
  },
  login: {
    title: "Iniciar sessão",
    fields: {
      email: "Email",
      password: "Palavra-passe",
      accessCode: "Código de acesso"
    },
    button: "Iniciar sessão",
    errors: {
      invalidCode: "Código de acesso inválido",
      invalidCredentials: "Email ou palavra-passe incorretos"
    }
  },
  metiers: {
    title: "Gestão dos ofícios",
    backButton: "Voltar",
    menuiserie: {
      title: "Fotos de carpintaria",
      description: "Gerir as fotos que aparecem na secção carpintaria",
      addButton: "Adicionar uma foto"
    },
    serrurerie: {
      title: "Fotos de serralharia",
      description: "Gerir as fotos que aparecem na secção serralharia",
      addButton: "Adicionar uma foto"
    },
    photoModal: {
      addTitle: "Adicionar uma foto",
      editTitle: "Modificar a foto",
      fields: {
        title: "Título",
        titlePlaceholder: "Ex: Janelas em alumínio",
        alt: "Texto alternativo",
        altPlaceholder: "Descrição para a acessibilidade",
        photo: "Foto",
        photoHelp: "Formatos aceites: JPG, PNG. Tamanho máx: 2 Mo"
      },
      buttons: {
        browse: "Procurar",
        cancel: "Cancelar",
        save: "Guardar"
      }
    }
  }
};