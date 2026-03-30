module Unit
  module Types
    class Profession
      ACCOUNTANT = 'Accountant'
      ACTOR = 'Actor'
      ADMINISTRATOR = 'Administrator'
      ANALYST = 'Analyst'
      ARCHITECT = 'Architect'
      ARTIST = 'Artist'
      ATTORNEY = 'Attorney'
      AUDITOR = 'Auditor'
      BANKER = 'Banker'
      BARBER = 'Barber'
      BARTENDER = 'Bartender'
      BOOKKEEPER = 'Bookkeeper'
      BROKER = 'Broker'
      BUSINESS_OWNER = 'BusinessOwner'
      CHEF = 'Chef'
      CLERGY = 'Clergy'
      COACH = 'Coach'
      CONSULTANT = 'Consultant'
      CONTRACTOR = 'Contractor'
      CUSTOMER_SERVICE_REPRESENTATIVE = 'CustomerServiceRepresentative'
      DENTIST = 'Dentist'
      DESIGNER = 'Designer'
      DEVELOPER = 'Developer'
      DOCTOR = 'Doctor'
      DRIVER = 'Driver'
      ECONOMIST = 'Economist'
      EDUCATOR = 'Educator'
      ELECTRICIAN = 'Electrician'
      ENGINEER = 'Engineer'
      ENTREPRENEUR = 'Entrepreneur'
      EVENT_PLANNER = 'EventPlanner'
      EXECUTIVE = 'Executive'
      FARMER = 'Farmer'
      FINANCIAL_ADVISOR = 'FinancialAdvisor'
      FIREFIGHTER = 'Firefighter'
      FISHERMAN = 'Fisherman'
      FLIGHT_ATTENDANT = 'FlightAttendant'
      FREELANCER = 'Freelancer'
      GOVERNMENT_EMPLOYEE = 'GovernmentEmployee'
      GRAPHIC_DESIGNER = 'GraphicDesigner'
      HEALTHCARE_WORKER = 'HealthcareWorker'
      HR_PROFESSIONAL = 'HRProfessional'
      INSURANCE_AGENT = 'InsuranceAgent'
      INVESTOR = 'Investor'
      IT_SPECIALIST = 'ITSpecialist'
      JANITOR = 'Janitor'
      JOURNALIST = 'Journalist'
      LABORER = 'Laborer'
      LAW_ENFORCEMENT_OFFICER = 'LawEnforcementOfficer'
      LAWYER = 'Lawyer'
      LIBRARIAN = 'Librarian'
      LOGISTICS_COORDINATOR = 'LogisticsCoordinator'
      MANAGER = 'Manager'
      MARKETING_PROFESSIONAL = 'MarketingProfessional'
      MECHANIC = 'Mechanic'
      MILITARY_PERSONNEL = 'MilitaryPersonnel'
      MUSICIAN = 'Musician'
      NURSE = 'Nurse'
      OPTOMETRIST = 'Optometrist'
      PAINTER = 'Painter'
      PHARMACIST = 'Pharmacist'
      PHOTOGRAPHER = 'Photographer'
      PHYSICAL_THERAPIST = 'PhysicalTherapist'
      PILOT = 'Pilot'
      PLUMBER = 'Plumber'
      POLICE_OFFICER = 'PoliceOfficer'
      PROFESSOR = 'Professor'
      PROGRAMMER = 'Programmer'
      PROJECT_MANAGER = 'ProjectManager'
      REAL_ESTATE_AGENT = 'RealEstateAgent'
      RECEPTIONIST = 'Receptionist'
      RESEARCHER = 'Researcher'
      RETAIL_WORKER = 'RetailWorker'
      SALESPERSON = 'Salesperson'
      SCIENTIST = 'Scientist'
      SOCIAL_WORKER = 'SocialWorker'
      SOFTWARE_ENGINEER = 'SoftwareEngineer'
      STUDENT = 'Student'
      SURGEON = 'Surgeon'
      TEACHER = 'Teacher'
      TECHNICIAN = 'Technician'
      THERAPIST = 'Therapist'
      TRAINER = 'Trainer'
      VETERINARIAN = 'Veterinarian'
      WAITER_WAITRESS = 'WaiterWaitress'
      WRITER = 'Writer'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid profession: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
